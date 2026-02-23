//
//  ScaneView.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import SwiftUI

import SwiftUI

struct ScanView: View {
    @StateObject var viewModel: ScanViewModel = ScanViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ScannerPreviewView(viewModel: viewModel)
                        .cornerRadius(12)
                        .padding()
                    
                    if !viewModel.isScanning {
                        Color.black.opacity(0.5)
                            .cornerRadius(12)
                            .padding()
                        Text("Tap Start to scan")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                
                if let code = viewModel.scannedCode {
                    VStack(spacing: 10) {
                        Text("Scanned Code:")
                            .font(.headline)
                        Text(code)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        HStack {
                            Button(action: {
                                UIPasteboard.general.string = code
                            }) {
                                Label("Copy", systemImage: "doc.on.clipboard")
                            }
                            .buttonStyle(.bordered)
                            
                            if let url = URL(string: code), UIApplication.shared.canOpenURL(url) {
                                Button(action: {
                                    UIApplication.shared.open(url)
                                }) {
                                    Label("Open URL", systemImage: "link")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                    .padding()
                } else {
                    Text("No code scanned yet.")
                        .foregroundColor(.secondary)
                        .padding()
                }
                
                HStack(spacing: 30) {
                    Button(action: {
                        viewModel.startScanning()
                    }) {
                        Label("Start", systemImage: "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: {
                        viewModel.stopAndClear()
                    }) {
                        Label("Reset", systemImage: "arrow.counterclockwise")
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top)
                
                Spacer()
            }
            .navigationTitle("Scan QR Code")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationDestination(item: $viewModel.scannedCode, destination: { destination in
                    ScanResultView(scannedText: destination)
            })
        }
    }
}
