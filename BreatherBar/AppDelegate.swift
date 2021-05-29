//
//  AppDelegate.swift
//  BreatherBar
//
//  Created by Martin Blampied on 26/05/2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    var statusBarMenu: NSMenu!
    let popover = NSPopover()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        SettingsManager.shared.statusBarIconAnimationUtils =
            StatusBarIconAnimationUtils.init(statusBarItem: statusItem)
        if let button = self.statusItem.button {
            button.action = #selector(AppDelegate.togglePopover(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        
        self.statusBarMenu = NSMenu(title: "Status Bar Menu")
        self.statusBarMenu.delegate = self
        self.statusBarMenu.addItem(
               withTitle: SettingsManager.shared.getPlayPauseBtnText(),
               action: #selector(AppDelegate.playPausePressed(_:)),
               keyEquivalent: "")
           statusBarMenu.addItem(
               withTitle: "Quit",
               action: #selector(AppDelegate.quitPressed(_:)),
               keyEquivalent: "")
        
        SettingsManager.shared.statusBarIconAnimationUtils?.startAnimating()
        self.popover.contentViewController = ViewController.newInsatnce()
        self.popover.animates = false
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func togglePopover(_ sender: NSStatusItem) {
        let event = NSApp.currentEvent!
        if event.type ==  NSEvent.EventType.rightMouseUp {
            self.statusBarMenu.items[0].title = SettingsManager.shared.getPlayPauseBtnText()
            statusItem.menu = statusBarMenu // add menu to button...
            statusItem.button?.performClick(nil) // ...and click
        } else {
            if self.popover.isShown {
                closePopover(sender: sender)
            }
            else {
                showPopover(sender: sender)
            }
        }
    }
    
    @objc func menuDidClose(_ menu: NSMenu) {
        statusItem.menu = nil // remove menu so button works as before
    }
    
    
    @objc func playPausePressed(_ sender: NSStatusItem) {
        if (SettingsManager.shared.isPaused) {
            SettingsManager.shared.isPaused = false
            SettingsManager.shared.statusBarIconAnimationUtils?.startAnimating()
        } else {
            SettingsManager.shared.isPaused = true
            SettingsManager.shared.statusBarIconAnimationUtils?.stopAnimating()
        }
    }
    
    @objc func quitPressed(_ sender: NSStatusItem) {
        NSApplication.shared.terminate(self)
    }
    
    
    func showPopover(sender: Any?) {
        if let button = self.statusItem.button {
            self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }

    func closePopover(sender: Any?)  {
        self.popover.performClose(sender)
    }


}

