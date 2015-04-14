//
//  ViewController.swift
//  EZAudioDemo
//
//  Created by 吴 海兴 on 15/4/12.
//  Copyright (c) 2015年 吴 海兴. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EZMicrophoneDelegate {
    
    @IBOutlet weak var audioPlot: EZAudioPlotGL!
    @IBOutlet weak var timerLabel: UILabel!
    
    internal var microphone: EZMicrophone!
    
    var timer = NSTimer()
    var count = 0
    func updateTimerLabel() {
        count++
        var second = count % 60
        var minute = (count-second) / 60
        timerLabel.text = "\(minute):\(second)"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        microphone = EZMicrophone(microphoneDelegate: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        audioPlot?.backgroundColor = UIColor.blackColor()
        audioPlot?.color = UIColor.orangeColor()
        audioPlot?.plotType = EZPlotType.Rolling
        audioPlot?.shouldFill = true
        audioPlot?.shouldMirror = true
        
        microphone.startFetchingAudio()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimerLabel"), userInfo: nil, repeats: true)
    }
    
    @IBAction func microphoneSwitch(sender: UISwitch) {
        if sender.on {
            microphone.startFetchingAudio()
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimerLabel"), userInfo: nil, repeats: true)
            
        } else {
            timer.invalidate()
            microphone.stopFetchingAudio()
        }
    }

    func microphone(microphone: EZMicrophone!,
        hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>,
        withBufferSize bufferSize: UInt32,
        withNumberOfChannels numberOfChannels: UInt32) {
        dispatch_async(dispatch_get_main_queue()) {
            self.audioPlot.updateBuffer(buffer.memory, withBufferSize: bufferSize)
        }
    }
}