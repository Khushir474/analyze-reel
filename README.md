# Analyze_Reel

Claude Code skill: paste an Instagram Reel, TikTok, Short, any yt-dlp URL or a local mp4, and get back
what the video teaches (steps, settings, values, timestamps) from its speech, on-screen text, caption and frames.
All heavy work runs locally, so Claude reads one small `reel.md` instead of a video.

## Needs (macOS)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp): `uv tool install yt-dlp` (or `brew install yt-dlp`)
- ffmpeg: `brew install ffmpeg`
- [Handy](https://handy.computer) in `/Applications` with a transcription model downloaded (local speech to text)
- Xcode Command Line Tools (`swiftc`): the OCR helper `ocr.swift` builds itself on first run, using macOS Vision
- Chrome logged in to Instagram: downloads use its cookies (first run asks Keychain for "Chrome Safe Storage")

## Install
```
git clone <this repo> ~/.claude/skills/analyze-reel
/usr/bin/python3 ~/.claude/skills/analyze-reel/reel.py --selftest
```
Then in Claude Code: `/analyze-reel <url> [what to do with it]`.

## Files
- `SKILL.md`: what Claude does, including how to flag a broken stage and propose a fix
- `reel.py`: download, transcribe, OCR, frame sheet; caches in `~/.cache/analyze-reel/` and cleans up after itself
- `ocr.swift`: Vision text recognition, compiled to `ocr` on first use
