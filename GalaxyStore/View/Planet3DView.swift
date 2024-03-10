//
//  Planet3DView.swift
//  GalaxyStore
//
//  Created by ThangDDB on 09/03/2024.
//

import SwiftUI
import RealityKit

struct Planet3DView: View {
    @Environment(\.dismissWindow) var dismissWindow
    
    var body: some View {
        Model3D(named: "Earth") { model in
            model
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
        .overlay(alignment: .bottom) {
            Button(action: {
                dismissWindow(id: "Earth")
            }, label: {
                Text("Dismiss")
            })
            .padding().glassBackgroundEffect()
        }
    }
}

#Preview {
    Planet3DView()
}
