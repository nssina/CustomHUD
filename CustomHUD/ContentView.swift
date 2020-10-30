//
//  ContentView.swift
//  CustomHUD
//
//  Created by Sina Rabiei on 10/30/20.
//

import SwiftUI

struct ContentView: View {
    @State private var showHUD = false

    func dismissHUDAfterTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showHUD = false
        }
    }

    @ViewBuilder var body: some View {
        ZStack(alignment: .top) {
            NavigationView {
                Button("Save image") {
                    withAnimation {
                        self.showHUD = true
                        dismissHUDAfterTime()
                    }
                }
                .navigationTitle("Content View")
            }
            HUD()
                .offset(y: showHUD ? 0 : -100)
                .animation(.easeInOut)
        }
    }
}

struct HUD: View {
    @ViewBuilder var body: some View {
        Label("Saved image", systemImage: "photo")
            .foregroundColor(.gray)
            .padding(.horizontal, 10)
            .padding(14)
            .background(
                Blur(style: .systemMaterial)
                    .clipShape(Capsule())
                    .shadow(color: Color(.black).opacity(0.22), radius: 12, x: 0, y: 5)
            )
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
