//
//  DocumentModel.swift
//  Nimble Text
//

import AppKit
import Observation

@Observable
final class DocumentModel {
    var text: String = "" {
        didSet { updateWindowEditedState() }
    }
    var fileURL: URL?

    /// The editor's window, reported by the view once it is attached.
    @ObservationIgnored weak var window: NSWindow? {
        didSet { updateWindowEditedState() }
    }

    /// Contents of `fileURL` as of the last successful save, or the launch text before the first save.
    private var lastSavedText: String = ""

    var isDirty: Bool { text != lastSavedText }

    init() {
        if let clipboardText = NSPasteboard.general.string(forType: .string) {
            text = clipboardText
        }
        lastSavedText = text
    }

    func save() {
        guard let url = fileURL else {
            saveAs()
            return
        }
        do {
            try write(to: url)
        } catch {
            presentSaveError(error, for: url, offerSaveAs: true)
        }
    }

    func saveAs() {
        let panel = NSSavePanel()
        panel.nameFieldStringValue = fileURL?.lastPathComponent ?? "untitled.txt"
        panel.canCreateDirectories = true
        panel.isExtensionHidden = false
        panel.allowsOtherFileTypes = true
        guard panel.runModal() == .OK, let url = panel.url else { return }
        do {
            try write(to: url)
            fileURL = url
            updateWindowEditedState()
        } catch {
            presentSaveError(error, for: url, offerSaveAs: false)
        }
    }

    private func write(to url: URL) throws {
        try text.write(to: url, atomically: true, encoding: .utf8)
        lastSavedText = text
        updateWindowEditedState()
    }

    private func presentSaveError(_ error: Error, for url: URL, offerSaveAs: Bool) {
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = "Couldn’t save “\(url.lastPathComponent)”"
        alert.informativeText = error.localizedDescription
        if offerSaveAs {
            alert.addButton(withTitle: "Save As…")
            alert.addButton(withTitle: "Cancel")
            if alert.runModal() == .alertFirstButtonReturn {
                saveAs()
            }
        } else {
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }

    func updateWindowEditedState() {
        window?.isDocumentEdited = isDirty
        window?.representedURL = fileURL
    }

    func copyToClipboardIfNeeded() {
        guard !text.isEmpty else { return }
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
    }
}
