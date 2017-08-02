//
//  AppDelegate.swift
//  lux
//
//  Created by Christopher Newton on 30.07.17.
//  Copyright © 2017 Newton Design. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let lux = Lux()
    
    let menu = NSMenu()
    let statusItem = NSStatusBar.system().statusItem(withLength: -1)
    let statusSlider = NSSlider()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let menuItem = NSMenuItem()
        let averageBrightness: Float = lux.getAverage()
        
        statusSlider.target = self
        statusSlider.action = #selector(AppDelegate.sliderChanged(_:))
        statusSlider.sliderType = NSSliderType.linear
        statusSlider.setFrameSize(NSSize(width: 24, height:160))
        statusSlider.isVertical = true
        statusSlider.floatValue = averageBrightness
        
        menuItem.view = statusSlider
        menu.addItem(menuItem)
        
        statusItem.title = "☀"
        statusItem.menu = menu
        
        
        lux.set(level: averageBrightness)
    }
    
    @IBOutlet var slider: NSSlider!
    var sliderValue: Float = 0
    
    @IBAction func sliderChanged(_ sender: Any) {
        lux.set(level: statusSlider.floatValue)
        menu.cancelTracking()
    }
    
}
