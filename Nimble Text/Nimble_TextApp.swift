//
//  Nimble_TextApp.swift
//  Nimble Text
//
//  Created by alain on 28.06.2026.
//

import SwiftUI

@main
struct Nimble_TextApp: App {
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        Window("Nimble Text", id: "main") {
            ContentView()
                .environment(appDelegate.document)
        }
        .commands {
            CommandGroup(replacing: .saveItem) {
                Button("Save") { appDelegate.document.save() }
                    .keyboardShortcut("s", modifiers: .command)
                Button("Save As…") { appDelegate.document.saveAs() }
                    .keyboardShortcut("s", modifiers: [.command, .shift])
            }
            CommandGroup(after: .pasteboard) {
                Button("Copy All") { appDelegate.document.copyToClipboardIfNeeded() }
                    .keyboardShortcut("c", modifiers: [.command, .shift])
                    .disabled(appDelegate.document.text.isEmpty)
            }
        }
    }
}
