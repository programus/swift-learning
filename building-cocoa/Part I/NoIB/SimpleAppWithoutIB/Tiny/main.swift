//
//  Tiny.swift
//  A tiny cocoa application that creates a window
//  and then displays graphics in it.
//  IB is not used to create this application.
//
//  This is the swift version of Tiny.m in
//  Building Cocoas Application boo.
//
//  Created by Programus on 15-02-13.
//
//

import Cocoa

// global consts & vars

// application
let app = NSApplication.sharedApplication()
// define window in global scope to prevent
// disappearing caused by auto release.
var win: NSWindow?

// A DemoView to draw the image.
class DemoView : NSView, NSWindowDelegate {
    func x(angle: Double) ->Double {
        return (sin(angle) + 1) * Double(self.bounds.size.width) * 0.5
    }
    
    func y(angle: Double) ->Double {
        return (cos(angle) + 1) * Double(self.bounds.size.height) * 0.5
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let n = 12      // number of sides of the polygon
        
        // get the size of the application's window and view objects
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        
        NSColor.whiteColor().set()  // set the drawing color to white
        NSRectFill(self.bounds)     // fill the view with color set
        
        // the following statements trace two polygons with n sides
        // and connect all of the vertices with lines
        
        NSColor.blackColor().set()  // set the drawing color to black
        
        let limit = 2 * M_PI
        let step = limit / Double(n)
        for var f: Double = 0; f < limit; f += step {
            let p1 = NSPoint(x: CGFloat(self.x(f)), y: CGFloat(self.y(f)))
            for var g: Double = 0; g < limit; g += step {
                let p2 = NSPoint(x: CGFloat(self.x(g)), y: CGFloat(self.y(g)))
                NSBezierPath.strokeLineFromPoint(p1, toPoint: p2)
            }
        }
    }
    
    func windowWillClose(notification: NSNotification) {
        // app is defined in the main entry part at the end of this file.
        app.terminate(self)
    }
}

// set up the window environments
func setup() {
    let graphicsRect = NSMakeRect(100, 350, 400, 400)
    let myWindow = NSWindow(
        contentRect: graphicsRect,
        styleMask: NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask,
        backing: NSBackingStoreType.Buffered,
        defer: false)
    let myView = DemoView(frame: graphicsRect)
    
    myWindow.contentView = myView
    myWindow.delegate = myView
    myWindow.makeKeyAndOrderFront(nil)
    win = myWindow
}

// main program
setup()
app.run()
