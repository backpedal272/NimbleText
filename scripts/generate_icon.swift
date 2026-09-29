// Generates the Nimble Text app icon master (1024×1024, sRGB, opaque).
// Concept: a clipboard of text. Follows "Nimble Icons style guide v2".
// Usage: swift scripts/generate_icon.swift <output.png>  (then export sizes per the style guide)

import AppKit
import CoreGraphics

let sRGB = CGColorSpace(name: CGColorSpace.sRGB)!
let nimbleBlue = CGColor(srgbRed: 0 / 255, green: 154 / 255, blue: 214 / 255, alpha: 1)
let deepBlue = CGColor(srgbRed: 0 / 255, green: 108 / 255, blue: 165 / 255, alpha: 1)
let cream = CGColor(srgbRed: 250 / 255, green: 248 / 255, blue: 244 / 255, alpha: 1)

let output = CommandLine.arguments.dropFirst().first ?? "AppIcon.png"

let ctx = CGContext(data: nil, width: 1024, height: 1024, bitsPerComponent: 8, bytesPerRow: 0, space: sRGB,
                    bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)!

// Background: diagonal gradient, Nimble Blue top-left → Deep Blue bottom-right.
let gradient = CGGradient(colorsSpace: sRGB, colors: [nimbleBlue, deepBlue] as CFArray, locations: [0, 1])!
ctx.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 1024), end: CGPoint(x: 1024, y: 0), options: [])

// 512 grid, top-left origin.
ctx.translateBy(x: 0, y: 1024)
ctx.scaleBy(x: 2, y: -2)

func fillRoundedRect(_ rect: CGRect, radius: CGFloat, _ color: CGColor) {
    ctx.setFillColor(color)
    ctx.addPath(CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil))
    ctx.fillPath()
}

func strokeLine(from x1: CGFloat, to x2: CGFloat, y: CGFloat) {
    ctx.setStrokeColor(nimbleBlue)
    ctx.setLineWidth(34)
    ctx.setLineCap(.round)
    ctx.move(to: CGPoint(x: x1, y: y))
    ctx.addLine(to: CGPoint(x: x2, y: y))
    ctx.strokePath()
}

// Board 280×316 with a clip tab on top; the whole mark spans y 92…436.
fillRoundedRect(CGRect(x: 116, y: 120, width: 280, height: 316), radius: 60, cream)
fillRoundedRect(CGRect(x: 196, y: 92, width: 120, height: 64), radius: 26, cream)
ctx.setFillColor(nimbleBlue)
ctx.fillEllipse(in: CGRect(x: 238, y: 100, width: 36, height: 36))

// Three lines of text, the last one short.
strokeLine(from: 180, to: 332, y: 222)
strokeLine(from: 180, to: 332, y: 290)
strokeLine(from: 180, to: 268, y: 358)

let png = NSBitmapImageRep(cgImage: ctx.makeImage()!).representation(using: .png, properties: [:])!
try png.write(to: URL(fileURLWithPath: output))
print("Wrote \(output)")
