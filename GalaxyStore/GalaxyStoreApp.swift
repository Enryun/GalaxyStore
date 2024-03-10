//
//  GalaxyStoreApp.swift
//  GalaxyStore
//
//  Created by ThangDDB on 09/03/2024.
//

import SwiftUI
import SwiftData

@main
struct GalaxyStoreApp: App {
    
    private let modelContainer: ModelContainer
    private let fileManager: FileStorageManager
    
    init() {
        fileManager = FileStorageManager()
        do {
            modelContainer = try ModelContainer(for: PlanetModelPersistence.self)
        } catch {
            print(error.localizedDescription)
            fatalError("Could not initialize ModelContainer")
        }
    }
            
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(modelContainer)
        .environment(fileManager)
        .windowStyle(.plain)
        .defaultSize(CGSize(width: 1800, height: 1800))
        
        WindowGroup(id: Constant.WindowId.planetWindowId) {
            Planet3DView()
        }
        .modelContainer(modelContainer)
        .environment(fileManager)
        .windowStyle(.volumetric)
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
    }
}
