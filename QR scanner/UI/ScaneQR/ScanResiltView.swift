//
//  ScanResiltView.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import SwiftUI

struct ScanResultView: View {
    let scannedText: String

    var body: some View {
        VStack {
            Text(scannedText)
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
    }

    var backgroundColor: Color {
        switch scannedText.lowercased() {
        case "red": return .red
        case "green": return .green
        case "blue": return .blue
        default: return .white
        }
    }
}
