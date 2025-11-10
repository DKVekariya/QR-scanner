//
//  GenerateViewModel.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import SwiftUI
import Combine

final class GenerateViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var qrImage: UIImage? = nil
    
    func generateQRCode() {
        guard !inputText.isEmpty else {
            qrImage = nil
            return
        }
        qrImage = QRCodeGenerator.generateQRCode(from: inputText, height: 400, padding: 10, foregroundColor: .black, backgroundColor: .white)
    }
}
