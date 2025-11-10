//
//  GenerateView.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import SwiftUI

struct GenerateView: View {
    @StateObject var viewModel: GenerateViewModel
    
    init(viewModel: GenerateViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    TextField("Enter text to encode", text: $viewModel.inputText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal)
                    
                    Button("Generate QR Code") {
                        viewModel.generateQRCode()
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    
                    QRImageView(image: viewModel.qrImage)
                    
                    Spacer()
                }
            }
            .navigationTitle("Generate QR Code")
        }
    }
}

struct GenerateView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateView(viewModel: GenerateViewModel())
    }
}
