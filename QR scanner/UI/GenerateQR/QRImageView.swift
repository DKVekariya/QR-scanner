//
//  QRInageView.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import SwiftUI

struct QRImageView: View {
    let image: UIImage?

    var body: some View {
        Group {
            if let ui = image {
                Image(uiImage: ui)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .background(Color.white)
                    .cornerRadius(12)
            } else {
                Text("No QR Code Generated")
                    .foregroundColor(.secondary)
                    .frame(width: 300, height: 300)
                    .background(Color(.systemGray5))
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}
struct QRImageView_Previews: PreviewProvider {
    static var previews: some View {
        QRImageView(image: nil)
    }
}
