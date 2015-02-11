//
//  AppDelegate.swift
//  TrackMix
//
//  Created by 王 元 on 15-01-24.
//  Copyright (c) 2015年 programus. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var track = Track()

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var slider: NSSlider!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.updateUserInterface()
    }

    @IBAction func mute(sender: AnyObject) {
        self.track.volumn = 0
        self.updateUserInterface()
    }
    
    @IBAction func takeFloatValueForVolumnFrom(sender: AnyObject) {
        var v: Float = 0
        if let floatValue = sender.floatValue {
            v = floatValue
        }
        self.track.volumn = v
        self.updateUserInterface()
    }
    
    private func updateUserInterface() {
        self.textField.floatValue = self.track.volumn
        self.slider.floatValue = self.track.volumn
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

