import AppKit

// ビルド方法
// swiftc -o copy_rich_text copy_rich_text.swift

guard CommandLine.arguments.count == 3 else {
  print("Usage: copy_rich_text <url> <title>\n", stderr)
  exit(1)
}

let url = CommandLine.arguments[1]
let title = CommandLine.arguments[2]
let html = "<a href=\"\(url)\">\(title)</a>"

let pasteboard = NSPasteboard.general
pasteboard.clearContents()
if let data = html.data(using: .utf8) {
  pasteboard.setData(data, forType: .html)
}
pasteboard.setString(html, forType: .string)
