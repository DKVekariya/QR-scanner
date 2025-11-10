//
//  ContentView.swift
//  QR scanner
//
//  Created by DK on 10/11/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GenerateView(viewModel: GenerateViewModel())
                .tabItem {
                    Label("Generate", systemImage: "qrcode")
                }
            ScanView(viewModel: ScanViewModel())
                .tabItem {
                    Label("Scan", systemImage: "camera.viewfinder")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
