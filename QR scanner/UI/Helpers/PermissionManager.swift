//
//  PermissionManager.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import Foundation
import AVFoundation

struct PermissionManager {
    static func checkCameraPermission() async throws {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .authorized:
            return
        case .notDetermined:
            try await withCheckedThrowingContinuation { continuation in
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    if granted {
                        continuation.resume()
                    } else {
                        continuation.resume(throwing: PermissionError.denied)
                    }
                }
            }
        case .denied, .restricted:
            throw PermissionError.denied
        @unknown default:
            throw PermissionError.unknown
        }
    }
    
    enum PermissionError: Error {
        case denied, unknown
    }
}
