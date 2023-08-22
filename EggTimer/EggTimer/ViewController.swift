//
//  ViewController.swift
//  EggTimer
//
//  Created by Arda Nar on 8.08.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft" : 180, "Medium" : 420, "Hard" : 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = ((sender as AnyObject).currentTitle)!  // Soft, Medium, Hard
        totalTime = eggTimes[hardness!]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            
            let percentageProgress = Float(secondsPassed) / Float(totalTime)  // Değişkenleri tek olarak Float alınması lazım bölünüp flota alırsak değişen bir şey olmaz
            
            progressBar.progress = percentageProgress
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            // Ses çalma işlemi
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {return}
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                guard let player = player else {return}
                player.play()
            } catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    }
    

