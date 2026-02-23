//
//  ScannerView.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import SwiftUI
import UIKit
import AVFoundation

struct ScannerPreviewView: UIViewRepresentable {
    @ObservedObject var viewModel: ScanViewModel

    class PreviewView: UIView {
        weak var viewModel: ScanViewModel?

        override func layoutSubviews() {
            super.layoutSubviews()
            viewModel?.updatePreviewLayerFrame(to: bounds)
        }
    }

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.viewModel = viewModel
        view.backgroundColor = .black
        DispatchQueue.main.async {
            viewModel.configureSession(in: view)
        }
        return view
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {
        // No-op: layoutSubviews handles frame update
    }

    static func dismantleUIView(_ uiView: PreviewView, coordinator: ()) {
    }
}
