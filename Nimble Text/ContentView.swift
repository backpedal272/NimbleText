//
//  ContentView.swift
//  Nimble Text
//

import SwiftUI

struct ContentView: View {
    @Environment(DocumentModel.self) private var document
    @FocusState private var isFocused: Bool
    @State private var selection: TextSelection?

    var body: some View {
        @Bindable var document = document
        TextEditor(text: $document.text, selection: $selection)
            .font(.system(size: 15))
            .scrollContentBackground(.hidden)
            .padding(8)
            .focused($isFocused)
            .navigationTitle(document.fileURL?.lastPathComponent ?? "Nimble Text")
            .background(WindowAccessor { document.window = $0 })
            .onAppear {
                DispatchQueue.main.async {
                    isFocused = true
                    selection = TextSelection(insertionPoint: document.text.endIndex)
                }
            }
    }
}

/// Reports the `NSWindow` hosting this view so the model can drive the edited dot and proxy icon.
private struct WindowAccessor: NSViewRepresentable {
    let onWindowChange: (NSWindow?) -> Void

    func makeNSView(context: Context) -> NSView {
        WindowReportingView(onWindowChange: onWindowChange)
    }

    func updateNSView(_ nsView: NSView, context: Context) {}

    private final class WindowReportingView: NSView {
        let onWindowChange: (NSWindow?) -> Void

        init(onWindowChange: @escaping (NSWindow?) -> Void) {
            self.onWindowChange = onWindowChange
            super.init(frame: .zero)
        }

        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            onWindowChange(window)
        }
    }
}

#Preview {
    ContentView()
        .environment(DocumentModel())
}
