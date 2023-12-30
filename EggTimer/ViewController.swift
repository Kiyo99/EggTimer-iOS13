//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")

    
    let eggTimes = ["Soft":300, "Medium":420, "Hard":720]
    
    var timer = Timer()
    
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()

        let hardness = sender.currentTitle!
        var counter:Float = 0.0
        let totalTime:Float = Float(eggTimes[hardness]!)
        progressView.progress = 0.0
        resultText.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if (counter < totalTime){
                print("There are \(counter) seconds counted")
                counter+=1
                self.progressView.progress = counter/totalTime
            }
            else {
                self.timer.invalidate()
                self.resultText.text = "Your egg is done, just how you love it!"
                //play alarm
                do{
                    try AVAudioSession.sharedInstance().setCategory(.playback)
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch{
                    print(error)
                }
                self.player = try! AVAudioPlayer(contentsOf: self.url!)
                self.player.play()
                
            }
        }
        
    }
    
}
