import Foundation
import Cocoa

class StatusBarIconAnimationUtils: NSObject {
    private var currentFrame = 1
    private var statusBarItem: NSStatusItem!
    private var inhaleDuration = Double(SettingsManager.shared.breatherTimings.inhaleDurateion);
    private var exhaleDuration = Double(SettingsManager.shared.breatherTimings.exhaleDurateion);
    private var inhaleHoldDuration = Double(SettingsManager.shared.breatherTimings.inhaleHold);
    private var exhaleHoldDuration = Double(SettingsManager.shared.breatherTimings.exhaleHold);
    private var frameInterval = 0.1
    private var maxSize = 15
    
    private var frameRatioInhale = 1.0;
    private var frameRatioExhale = 1.0;
    private var holdEnd = 1.0;
    private var secondHoldEnd = 1.0;
    private var restartCycle = 1.0;
    private var animTimer : Timer;
    
    init(statusBarItem: NSStatusItem!) {
        self.animTimer = Timer.init()
        self.statusBarItem = statusBarItem
        super.init()
    }

    func startAnimating() {
        stopAnimating()
        inhaleDuration = Double(SettingsManager.shared.breatherTimings.inhaleDurateion);
        exhaleDuration = Double(SettingsManager.shared.breatherTimings.exhaleDurateion);
        inhaleHoldDuration = Double(SettingsManager.shared.breatherTimings.inhaleHold);
        exhaleHoldDuration = Double(SettingsManager.shared.breatherTimings.exhaleHold);
        currentFrame = 1
        frameRatioInhale = Double(maxSize)/(inhaleDuration/frameInterval)
        frameRatioExhale = Double(maxSize)/(exhaleDuration/frameInterval)
        holdEnd = inhaleDuration + inhaleHoldDuration;
        secondHoldEnd = inhaleDuration + inhaleHoldDuration + exhaleDuration;
        restartCycle = inhaleDuration + inhaleHoldDuration + exhaleDuration + exhaleHoldDuration;
        
        self.animTimer = Timer.scheduledTimer(timeInterval: frameInterval, target: self, selector: #selector(self.updateImage(_:)), userInfo: nil, repeats: true)
        
    }

    func stopAnimating() {
        setImage(frameCount: 1)
        self.animTimer.invalidate()
    }

    @objc private func updateImage(_ timer: Timer?) {
        setImage(frameCount: currentFrame)
        currentFrame += 1
    }

    private func setImage(frameCount: Int) {
        
        var size = 1.0;
        
        if (Double(currentFrame) < inhaleDuration/frameInterval) {
            size = (Double(currentFrame) * frameRatioInhale);
        } else if (Double(currentFrame) < holdEnd/frameInterval) {
            size = Double(maxSize);
        } else if (Double(currentFrame) < secondHoldEnd/frameInterval) {
            size =  Double(maxSize) - (Double(currentFrame - Int(holdEnd/frameInterval)) * frameRatioExhale)
        } else if (Double(currentFrame) > restartCycle/frameInterval) {
            currentFrame = 1;
        }
        
        let image = NSImage(gradientColors: [NSColor(red: 1, green: 1, blue: 1, alpha: 1)], imageSize: NSSize(width: size, height: size))
        image?.isTemplate = true // best for dark mode
        DispatchQueue.main.async {
            self.statusBarItem.button?.image = image
        }
    }
    
    
}
