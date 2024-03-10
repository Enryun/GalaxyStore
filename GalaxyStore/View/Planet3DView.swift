//
//  Planet3DView.swift
//  GalaxyStore
//
//  Created by ThangDDB on 09/03/2024.
//

import SwiftUI
import RealityKit
import SwiftData

struct Planet3DView: View {
    
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(FileStorageManager.self) private var fileManager: FileStorageManager
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<PlanetModelPersistence> { $0.isSelected }) private var planets: [PlanetModelPersistence]

    var body: some View {
        // For fetch Model from URL
        ZStack {
            if let urlPath = Bundle.main.path(forResource: planets.first?.name ?? "", ofType: "usdz") {
                let url = URL(fileURLWithPath: urlPath)
                Model3D(url: url) { model in
                    model
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            } else {
                // Fall back
                Model3D(named: planets.first?.name ?? "") { model in
                    model
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .overlay(alignment: .bottom) {
            Button(action: {
                dismissWindow(id: Constant.WindowId.planetWindowId)
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
