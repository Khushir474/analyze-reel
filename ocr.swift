// On-screen text via macOS Vision (no installs). Built once by reel.py: swiftc -O ocr.swift -o ocr
// Usage: ocr <image>...   prints "<image>\t<line>" per text line, top to bottom.
import AppKit
import Vision

for path in CommandLine.arguments.dropFirst() {
    guard let img = NSImage(contentsOfFile: path),
          let cg = img.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
        FileHandle.standardError.write("cannot read \(path)\n".data(using: .utf8)!)
        exit(1)
    }
    let req = VNRecognizeTextRequest()
    req.recognitionLevel = .accurate
    req.usesLanguageCorrection = true
    do { try VNImageRequestHandler(cgImage: cg).perform([req]) } catch {
        FileHandle.standardError.write("vision failed on \(path): \(error)\n".data(using: .utf8)!)
        exit(1)
    }
    for o in (req.results ?? []).sorted(by: { $0.boundingBox.minY > $1.boundingBox.minY }) {
        if let t = o.topCandidates(1).first, t.confidence > 0.4 { print("\(path)\t\(t.string)") }
    }
}
