//
//  NSImageExtensions.swift
//  BreatherBar
//
//  Created by Martin Blampied on 26/05/2021.
//

import Foundation
import Cocoa

extension NSImage {
    convenience init?(gradientColors: [NSColor], imageSize: NSSize) {
        guard let gradient = NSGradient(colors: gradientColors) else { return nil }
        let rect = NSRect(origin: CGPoint.zero, size: imageSize)
    
        self.init(size: rect.size)
        let path = NSBezierPath(ovalIn: rect)
        self.lockFocus()
        gradient.draw(in: path, angle: 0.0)
        self.unlockFocus()
        
    }
}
