//
//  AppDelegate.swift
//  Nimble Text
//

import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    let document = DocumentModel()

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        true
    }

    func applicationWillTerminate(_ notification: Notification) {
        document.copyToClipboardIfNeeded()
    }
}
