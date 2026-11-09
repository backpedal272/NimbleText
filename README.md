# Nimble Text

**Rich text in, plain text out. A minimal macOS editor that round-trips the clipboard.**

Copied something from a web page, a PDF or an email that pastes with its fonts, colors and links? Open Nimble Text: the formatting is gone and only the words are left. Edit them if you like, close the window, and the clean text is back on the clipboard, ready to paste.

> Free and open source (GPL-3.0). Part of [Nimble Apps](https://nimbleapps.ch).

## How it works

- **On launch** the editor is filled with the clipboard's text as plain text (fonts, colors and links are dropped), with the cursor at the end. If the clipboard holds no text, it starts empty.
- **On close (⌘W) or quit (⌘Q)** the whole document is copied back to the clipboard. An empty document leaves the clipboard untouched.
- **Copy All (⇧⌘C)** copies the document without closing.
- **Save (⌘S) / Save As (⇧⌘S)** writes UTF-8 plain text with any extension you type (`.txt`, `.md`, `.csv`, `.json`…).

One window, no tabs, no toolbar, no settings. Follows the system light or dark appearance.

## Privacy

Sandboxed and offline: no network access, no tracking, no account. The app only reads and writes the clipboard and the files you choose to save.

## Requirements

- macOS 15 Sequoia or later

## Install

[Download Nimble Text on the Mac App Store](https://apps.apple.com/app/nimble-text/id6785216951). It's free. More on [nimbleapps.ch](https://nimbleapps.ch/nimbletext/index.html).

## Build from source

You need Xcode.

```sh
git clone https://github.com/backpedal272/NimbleText.git
cd NimbleText
open "Nimble Text.xcodeproj"
```

Then choose **Product › Run**. To run it signed on your own Mac, pick your team under **Signing & Capabilities**.

## Contributing

Bug reports and suggestions are welcome in [Issues](https://github.com/backpedal272/NimbleText/issues). Contact: info@nimbleapps.ch.

## License

GPL-3.0. See [LICENSE](LICENSE).
