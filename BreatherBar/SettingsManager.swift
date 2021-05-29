//
//  SettingsManager.swift
//  BreatherBar
//
//  Created by Martin Blampied on 26/05/2021.
//

import Foundation


struct BreatherTimings {
    let inhaleDurateion: Int32
    let inhaleHold: Int32
    let exhaleDurateion: Int32
    let exhaleHold: Int32
}


class SettingsManager{
    
    static let shared = SettingsManager()
    
    var statusBarIconAnimationUtils : StatusBarIconAnimationUtils?
    var breatherTimings = BreatherTimings(inhaleDurateion: 4, inhaleHold: 1, exhaleDurateion: 4, exhaleHold: 1)
    var isPaused = false;
    
    //Initializer access level change now
    private init(){}
    
    func updateBreatherTimings(newValue: BreatherTimings) {
        breatherTimings = newValue;
    }
    
    func getPlayPauseBtnText() -> String {
        if (isPaused) {
            return "Play"
        }
        return "Pause"
    }
    
    
}

