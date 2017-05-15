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

    override func viewDidLoad() {
        super.viewDidLoad()
//        waveView.waveColor = UIColor.blue
        waveView.speed = 5
        
    }


    @IBAction func buttonTapped(_ sender: Any) {
        waveView.startWave()
        
    }

}

