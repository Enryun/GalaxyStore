//
//  ContentView.swift
//  GalaxyStore
//
//  Created by ThangDDB on 09/03/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent
import SwiftData

struct HomeView: View {
    
    @Query(sort: \PlanetModelPersistence.index, order: .forward) var planets: [PlanetModelPersistence]
    @Environment(\.modelContext) private var modelContext
    @Environment(FileStorageManager.self) private var fileManager: FileStorageManager
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Text("Galaxy Gallery")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .padding()
                        
                        Text("Welcome to Galaxy Gallery, where you can learn more about space and our Solar System")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                            .padding(.vertical)
                            .padding(.bottom)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(planets) { planet in
                                VStack(spacing: 24) {
                                    ImageWithCache(planet: planet)
                                    
                                    NavigationLink(value: planet) {
                                        Text(planet.name)
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.primary)
                                    }
                                    .padding()
                                }
                                .padding()
                                .glassBackgroundEffect()
                                .aspectRatio(2/2.7, contentMode: .fit)
                                .frame(width: max((geometry.size.width - (16 * 5)) / 4, 0))
                            }
                        }
                        .padding()
                    }
                }
                .navigationDestination(for: PlanetModelPersistence.self, destination: { card in
                    PlanetDetailView(planet: card)
                })
            }
            .padding()
        }
        .onLoad {
            do {
                let planetsData = try viewModel.fetchAllPlanets()
                try modelContext.delete(model: PlanetModelPersistence.self, includeSubclasses: true)
                for (index, planet) in planetsData.enumerated() {
                    viewModel.fakeFetchImageAndSaveLocalData(planet: planet, fileManager: fileManager)
                    let persistedCard = PlanetModelPersistence(name: planet.name, index: index, fact: planet.fact)
                    modelContext.insert(persistedCard)
                }
            } catch {
                print(error.localizedDescription)
            }            
        }
    }
}

#Preview(windowStyle: .automatic) {
    HomeView()
}
