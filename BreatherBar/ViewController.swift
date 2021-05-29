//
//  ViewController.swift
//  BreatherBar
//
//  Created by Martin Blampied on 26/05/2021.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var inhaleDurationTb: NSTextField!
    @IBOutlet weak var inhaleHoldDurationTb: NSTextField!
    @IBOutlet weak var exhaleDurationTb: NSTextField!
    @IBOutlet weak var exhaleHoldDurationTb: NSTextField!
    @IBOutlet weak var playPauseBtn: NSButton!
    
    
    static func newInsatnce() -> ViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("ViewController")
          
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
            fatalError("Unable to instantiate ViewController in Main.storyboard")
        }
        return viewcontroller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let timings = SettingsManager.shared.breatherTimings;
        inhaleDurationTb.intValue = timings.inhaleDurateion;
        inhaleHoldDurationTb.intValue = timings.inhaleHold;
        exhaleDurationTb.intValue = timings.exhaleDurateion;
        exhaleHoldDurationTb.intValue = timings.exhaleHold;
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        playPauseBtn.title = SettingsManager.shared.getPlayPauseBtnText()
    }
    
  
    @IBAction func playPauseClicked(_ sender: Any) {
        if (SettingsManager.shared.isPaused) {
            SettingsManager.shared.statusBarIconAnimationUtils?.startAnimating();
            SettingsManager.shared.isPaused = false;
            playPauseBtn.title = SettingsManager.shared.getPlayPauseBtnText()
        } else {
            SettingsManager.shared.statusBarIconAnimationUtils?.stopAnimating();
            SettingsManager.shared.isPaused = true;
            playPauseBtn.title = SettingsManager.shared.getPlayPauseBtnText()
        }
       
    }
    
    @IBAction func timingsDidChange(_ sender: Any) {
        SettingsManager.shared.updateBreatherTimings(newValue: BreatherTimings(inhaleDurateion: inhaleDurationTb.intValue, inhaleHold: inhaleHoldDurationTb.intValue, exhaleDurateion: exhaleDurationTb.intValue, exhaleHold: exhaleHoldDurationTb.intValue))
        // restart animation
        SettingsManager.shared.statusBarIconAnimationUtils?.startAnimating();
    }
    
    
    @IBAction func twitterClicked(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://twitter.com/MartinBlampied")!)
    }
    
    
    @IBAction func homeClicked(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://breather.bar")!)
    }
    
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    

}

