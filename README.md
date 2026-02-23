![iOS](https://img.shields.io/badge/iOS-18.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green.svg)

# 📱 SwiftUI QR Code Generator  & Scanner

A clean, modern QR code app built entirely with **SwiftUI**, **AVFoundation**, and **CoreImage**.  
This project demonstrates how to **generate**, **scan**, and share information using QR codes with a fully native iOS architecture.

🔗 Repository: https://github.com/DKVekariya/QR-scanner  

## ✨ Features

### 🔳 QR Code Generation
- Convert any **text or URL** into a high-quality QR code
- Customizable:
  - Size
  - Padding
  - Foreground color
  - Background color
- Clean white padded layout (ideal for screenshots & sharing)
- Instant preview after generation
- Built using **CoreImage QR filters**

### 📷 QR Code Scanning
- Real-time camera preview with scanning overlay
- Automatic QR detection
- Vibration feedback on successful scan
- Stops scanning after first valid result
- Displays scanned content with:
  - 📋 Copy to clipboard
  - 🌍 Open URL (if valid link detected)
- Dynamic background colors based on scanned text (e.g., “red” → red screen)

### 🎯 UX Highlights
- Simple tab navigation (Generate / Scan)
- Proper camera permission handling
- Clean MVVM architecture
- Graceful error handling
- Works on simulator (generation only)

## 📝 Article

I have also written a detailed article explaining this project step-by-step.  
You can read it here: [Mastering QR Code Generation & Scanning in SwiftUI](https://medium.com/@dkvekariya/ead7d23b0de1)

## 📸 Screenshots

| Generate Screen | Scan Screen |
|-----------------|------------|
| ![Generate](QR%20scanner/Documents/generator_light.jpeg) | ![Scan](QR%20scanner/Documents/scanner_light.jpeg) |

| Generate Screen | Scan Screen |
|-----------------|------------|
| ![Generate](QR%20scanner/Documents/generator_dark.jpeg) | ![Scan](QR%20scanner/Documents/scanner_dark.jpeg) |

*(Add screenshots inside a `screenshots/` folder in your repo)*

## 🚀 Getting Started

### Requirements
- **Xcode 16+**
- **iOS 18.0+**
- Physical iPhone/iPad recommended for scanning

### Installation

```bash
git clone https://github.com/DKVekariya/QR-scanner.git
cd QR-scanner
open QR\ scanner.xcodeproj
```

Select a real device (recommended for scanning)  
Build & Run (⌘R)  
Grant camera permission when prompted  

## 🏗️ Architecture Highlights

- MVVM pattern  
- Separate QR generation & scanning services  
- Clean separation between UI and business logic  
- Easy to extend with new QR features  

## 📱 Technologies Used

- SwiftUI  
- AVFoundation  
- CoreImage  
- Combine  
- UIKit interoperability (vibration, pasteboard, URL handling)  

## ⚠️ Known Limitations

- Scanning works only on physical devices  
- Supports QR codes only  
- No scan history  
- No advanced QR customization (logo embedding, error correction tuning)  

## 👨‍💻 Author

**Divyesh Vekariya**
- GitHub: [@DKVekariya](https://github.com/DKVekariya)
- Twitter: [@D_K_Vekariya](https://x.com/D_K_Vekariya)
- LinkedIn: [Divyesh Vekariya](https://www.linkedin.com/in/dkvekariya)
- DailyDev: [Divyesh Vekariya](https://app.daily.dev/divyesh_vekariya)
- DEV: [Divyesh Vekariya](https://dev.to/divyesh_vekariya)

## 🙏 Acknowledgments

- Inspired my May UPI Payment App
- Built following iOS 26+ design patterns
- Special thanks to the SwiftUI community

## ⭐ Show Your Support

If this project helped you, please give it a ⭐️!

---

**Built with ❤️ using SwiftUI**
