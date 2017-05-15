//
//  WaveView.swift
//  waveAnimationDemo
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 shang. All rights reserved.
//  y=Asin（ωx+φ）+h

import UIKit

public class WaveView: UIView {
    
    
    //MARK: Public
    
    /// 振幅 波浪高度默认 8
    public var amplitude: CGFloat = 8
    /// 波长 默认 350
    public var wavelength: CGFloat = 350
    ///速度单位秒 默认2s
    public var speed: TimeInterval = 2
    /// 波浪颜色 默认白色
    public var waveColor = UIColor.white {
        didSet {
            waveShape.fillColor = waveColor.cgColor
            otherWaveShape.fillColor = waveColor.withAlphaComponent(0.5).cgColor
        }
        
    }
    
    /// 开始
    public func startWave() {
        guard !isWave else { return }
        self.displayLink.isPaused = false
    }
    
    /// 停止
    //   public func stopWave() {
    //        self.displayLink.isPaused = true
    //    }
    // 是否正在动画
    public var isWave: Bool {
        return !self.displayLink.isPaused
    }
    
    
    //MARK: Private
    private var offsetX:CGFloat = 0;
    private var offsetY:CGFloat {return bounds.height - CGFloat(A)}
    private var A:CGFloat = 5;
    
    private var waveShape: CAShapeLayer  = {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.white.cgColor;
        shape.backgroundColor = UIColor.white.cgColor
        return shape
    }()
    
    private var otherWaveShape : CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.init(white: 1, alpha: 0.5).cgColor;
        shape.backgroundColor = UIColor.white.cgColor
        return shape
    }()
    
    private var displayLink = CADisplayLink()
    @objc private func drawWave() {
        let w = CGFloat((Double.pi) / Double(wavelength))
        if A<=0 {
            displayLink.isPaused = true
            A = amplitude
            offsetX = 0
            return
        }
        let path = UIBezierPath()
        let otherPath = UIBezierPath()
        otherPath.move(to: CGPoint.init(x: 0, y:bounds.height))
        path.move(to: CGPoint.init(x: 0, y:bounds.height))
        for i in 0..<Int(bounds.width) {
            let x = CGFloat(i)
            let  y = A * sin(w * CGFloat(i) + offsetX) + offsetY
            let y2 = A * sin(w * CGFloat(i) + offsetX * 0.5) + offsetY
            path.addLine(to: CGPoint.init(x: x, y: y))
            otherPath.addLine(to: CGPoint.init(x: x, y: y2))
        }
        path.addLine(to: CGPoint.init(x: bounds.width, y:bounds.height))
        path.close()
        otherPath.addLine(to: CGPoint.init(x: bounds.width, y:bounds.height))
        otherPath.close()
        waveShape.path = path.cgPath
        otherWaveShape.path = otherPath.cgPath
        A = A -  amplitude / (60 * CGFloat(speed))
        offsetX = offsetX + 0.1
        
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.layer.addSublayer(self.waveShape)
        self.layer.addSublayer(self.otherWaveShape)
        self.displayLink = CADisplayLink.init(target: self, selector: #selector(drawWave))
        displayLink.isPaused = true
        A = amplitude
        self.displayLink.add(to: RunLoop.current, forMode: .commonModes)
        
    }
    
    
}
