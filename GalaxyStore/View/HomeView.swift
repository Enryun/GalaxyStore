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
    
    @Query var recipes: [PlanetModelPersistence]
    @Environment(\.modelContext) private var modelContext
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)
    
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
                            ForEach(defaultCards) { card in
                                VStack(spacing: 24) {
                                    Image(card.name, bundle: .main)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                    NavigationLink(value: card) {
                                        Text(card.name)
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
                .navigationDestination(for: PlanetModel.self, destination: { card in
                    PlanetDetailView(card: card)
                })
            }
            .padding()
        }
        .onAppear {
            
        }
    }
    
    private func saveLocalSwiftData() {
        for card in defaultCards {
            let persistedCard = PlanetModelPersistence(name: card.name, fact: card.fact)
            modelContext.insert(persistedCard)
        }

        do {
            try modelContext.save()
        } catch {
            
        }
    }
}

#Preview(windowStyle: .automatic) {
    HomeView()
}




//Model3D(named: defaultCards[index].name) { model in
//    model
//        .resizable()
//        .aspectRatio(1, contentMode: .fit)
//} placeholder: {
//    ProgressView()
//}

//Model3D(named: defaultCards[index].name) { model in
//    model
//        .resizable()
//        .aspectRatio(1, contentMode: .fit)
//} placeholder: {
//    ProgressView()
//}

//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Menu {
//                        Button("Option 1") { print("Option 1 selected") }
//                        Button("Option 2") { print("Option 2 selected") }
//                        Button("Option 3") { print("Option 3 selected") }
//                    } label: {
//                        Label("Menu", systemImage: "ellipsis.circle")
//                    }
//                }
//            }

