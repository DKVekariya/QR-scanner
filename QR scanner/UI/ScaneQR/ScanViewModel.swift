//
//  ScanViewModel.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import SwiftUI
import Combine
import AVFoundation

final class ScanViewModel: ObservableObject {
    @Published var scannedCode: String? = nil
    @Published var isScanning: Bool = false
    @Published var showAlert: Bool = false
    
    @Published var alertMessage: String = ""
    
    var scannerService = QRCodeScannerService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        scannerService.codePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] code in
                self?.scannedCode = code
                self?.isScanning = false
            }
            .store(in: &cancellables)
    }
    
    func startScanning() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            DispatchQueue.main.async {
                self.isScanning = true
            }
            scannerService.startScanning()

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.isScanning = true
                        self?.scannerService.startScanning()
                    } else {
                        self?.alertMessage = "Camera permission denied."
                        self?.showAlert = true
                    }
                }
            }

        default:
            DispatchQueue.main.async {
                self.alertMessage = "Camera access is not available."
                self.showAlert = true
            }
        }
    }
    
    func stopAndClear() {
        self.isScanning = false
        self.scannedCode = nil
        
        scannerService.stopScanning()
    }
    
    func configureSession(in view: UIView) {
        do {
            try scannerService.configureSession(in: view)
        } catch {
            print("Failed to configure scanner: \(error)")
        }
    }
    
    func updatePreviewLayerFrame(to frame: CGRect) {
        DispatchQueue.main.async {
            self.scannerService.updatePreviewFrame(to: frame)
        }
    }
}
