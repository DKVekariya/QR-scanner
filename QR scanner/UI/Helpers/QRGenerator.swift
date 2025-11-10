//
//  QRGenerator.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

final class QRCodeGenerator {
    static func generateQRCode(from string: String, height: CGFloat = 300, padding: CGFloat = 5, foregroundColor: UIColor = .black, backgroundColor: UIColor = .white) -> UIImage? {
        guard let data = string.data(using: .utf8) else { return nil }
        
        let qrFilter = CIFilter.qrCodeGenerator()
        qrFilter.setValue(data, forKey: "inputMessage")
        guard let ciImage = qrFilter.outputImage else { return nil }
        
        // Apply color using FalseColor filter
        let colorFilter = CIFilter.falseColor()
        colorFilter.inputImage = ciImage
        colorFilter.color0 = CIColor(color: foregroundColor) // QR code pixels
        colorFilter.color1 = CIColor(color: backgroundColor) // Background
        guard let coloredImage = colorFilter.outputImage else { return nil }
        
        // Calculate scale to fit desired height including padding
        let originalSize = coloredImage.extent.size.height
        let scaledHeight = height - (padding * 2)
        let scale = scaledHeight / originalSize
        
        let scaledImage = coloredImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else { return nil }
        
        let qrSize = CGSize(width: scaledImage.extent.width, height: scaledImage.extent.height)
        let paddedSize = CGSize(width: qrSize.width + padding * 2, height: qrSize.height + padding * 2)
        
        UIGraphicsBeginImageContextWithOptions(paddedSize, false, 0)
        guard let graphicsContext = UIGraphicsGetCurrentContext() else { return nil }
        
        // Fill with background color
        graphicsContext.setFillColor(backgroundColor.cgColor)
        graphicsContext.fill(CGRect(origin: .zero, size: paddedSize))
        
        UIImage(cgImage: cgImage).draw(in: CGRect(origin: CGPoint(x: padding, y: padding), size: qrSize))
        
        let paddedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return paddedImage
    }
    
}
