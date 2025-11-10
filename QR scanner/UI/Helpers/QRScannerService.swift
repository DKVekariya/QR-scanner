//
//  QRScannerService.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import AVFoundation
import Combine
import UIKit

final class QRCodeScannerService: NSObject {
    let codePublisher = PassthroughSubject<String, Never>()
    
    private let captureSession = AVCaptureSession()
    private weak var previewLayer: AVCaptureVideoPreviewLayer?
    private weak var previewContainerView: UIView?
    
    func configureSession(in view: UIView) throws {
        previewContainerView = view
        view.backgroundColor = .black
        
        captureSession.beginConfiguration()
        
        guard let videoDevice = AVCaptureDevice.default(for: .video) else {
            throw ScannerError.cameraUnavailable
        }
        let videoInput = try AVCaptureDeviceInput(device: videoDevice)
        guard captureSession.canAddInput(videoInput) else {
            throw ScannerError.inputFailed
        }
        captureSession.addInput(videoInput)
        
        let metadataOutput = AVCaptureMetadataOutput()
        guard captureSession.canAddOutput(metadataOutput) else {
            throw ScannerError.outputFailed
        }
        captureSession.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]
        
        captureSession.commitConfiguration()
        

        let layer = AVCaptureVideoPreviewLayer(session: captureSession)
        layer.videoGravity = .resizeAspectFill
        previewLayer = layer
        view.layer.insertSublayer(layer, at: 0)
        
        previewLayer = layer
        
        // Observe layout changes so the layer updates
        view.layoutIfNeeded()
        
        // Optionally add overlay
        addOverlay()
    }
    
    func startScanning() {
        guard !captureSession.isRunning else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    func stopScanning() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    private func addOverlay(frameColor: UIColor = .green, lineWidth: CGFloat = 2.0) {
        guard let view = previewContainerView else { return }

        // Clear existing overlays
        view.layer.sublayers?.removeAll(where: { $0.name == "qrOverlay" })

        // Calculate centered square
        let padding: CGFloat = 80
        let size = min(view.bounds.width, view.bounds.height) - (2 * padding)
        let originX = (view.bounds.width - size) / 2
        let originY = (view.bounds.height - size) / 2
        let squareRect = CGRect(x: originX, y: originY, width: size, height: size)

        // Draw border layer
        let overlay = CAShapeLayer()
        overlay.name = "qrOverlay"
        overlay.path = UIBezierPath(roundedRect: squareRect, cornerRadius: 16).cgPath
        overlay.strokeColor = frameColor.cgColor
        overlay.fillColor = UIColor.clear.cgColor
        overlay.lineWidth = lineWidth

        view.layer.addSublayer(overlay)
    }
    
    func updatePreviewFrame(to frame: CGRect) {
        previewLayer?.frame = frame
    }
}

extension QRCodeScannerService: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        stopScanning()
        if let metadata = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           let stringValue = metadata.stringValue {
            vibrate()
            codePublisher.send(stringValue)
        }
    }
    
    func vibrate() {
        #if !targetEnvironment(simulator)
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        #endif
    }
}

extension QRCodeScannerService {
    enum ScannerError: Error {
        case cameraUnavailable
        case inputFailed
        case outputFailed
    }
}
