//
//  ImageWithCache.swift
//  GalaxyStore
//
//  Created by ThangDDB on 10/03/2024.
//

import SwiftUI

struct ImageWithCache: View {
    
    @Environment(FileStorageManager.self) private var fileManager: FileStorageManager
    let planet: PlanetModelPersistence
    @State private var imageURL: URL?

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
            case .failure(let error):
                let _ = print(error.localizedDescription)
                // Fall back, Place holder, may be error view
                Image(planet.name, bundle: .main)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
            @unknown default:
                // Replace with Error view
                EmptyView()
            }
        }
        .onLoad {
            // Load from cache
            if let localImageURL = fileManager.loadFileFromDiskWith(fileName: planet.localImageURL) {
                imageURL = localImageURL
            } 
            // Here load from Project asset but should replace with valid cloud URL
            else if let urlPath = Bundle.main.path(forResource: planet.name, ofType: Constant.FileType.png) {
                let url = URL(fileURLWithPath: urlPath)
                imageURL = url
            }
        }
    }
}

#Preview {
    ImageWithCache(planet: PlanetModelPersistence(name: "Earth", index: 3, fact: "Earth is the third planet from the Sun and the only known planet to support life. It has a diameter of approximately 12,742 km and is composed primarily of rock and metal. The Earth has a dense atmosphere that protects life on the planet and helps regulate the surface temperature. It has a magnetic field that protects the planet from harmful solar and cosmic radiation. The planet is approximately 4.54 billion years old and has a diverse array of habitats, including oceans, forests, deserts, and tundras. Life on Earth has evolved over millions of years, leading to the development of diverse species, including humans."))
}
