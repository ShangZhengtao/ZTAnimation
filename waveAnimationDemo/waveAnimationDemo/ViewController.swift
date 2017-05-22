//
//  ViewController.swift
//  waveAnimationDemo
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 shang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var waveView: WaveView!

    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var autoSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //颜色
        waveView.waveColor = UIColor.blue
        //动画时间2s
        waveView.speed = 2
        //浪高
        waveView.amplitude = 8
        //波长
        waveView.wavelength = 320
        //持续动画
//      waveView.alwaysAnimation = true
        
    }


    @IBAction func buttonTapped(_ sender: Any) {
        waveView.amplitude = CGFloat (Double(heightLabel.text!)!)
        waveView.speed = Double(durationLabel.text!)!
        waveView.alwaysAnimation = autoSwitch.isOn
        waveView.startWave()
        
    }


    @IBAction func heightChanged(_ sender: UISlider) {
        waveView.amplitude = CGFloat (Double(heightLabel.text!)!)
        self.heightLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func durationChanged(_ sender: UISlider) {
        waveView.speed = Double(durationLabel.text!)!
        self.durationLabel.text = "\(Int(sender.value))"
    }
}

