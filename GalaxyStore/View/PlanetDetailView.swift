//
//  PlanetDetail.swift
//  GalaxyStore
//
//  Created by ThangDDB on 09/03/2024.
//

import SwiftUI
import NaturalLanguage
import SwiftData

struct PlanetDetailView: View {
    
    let planet: PlanetModelPersistence
    @Environment(\.modelContext) private var modelContext
    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    @Query var planets: [PlanetModelPersistence]
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                VStack(spacing: 24) {
                    Text(planet.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(splitSentences(from: planet.fact), id: \.self) { sentence in
                            HStack(alignment: .top) {
                                Text("•")
                                    .padding(.trailing, 5)
                                Text(sentence)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                    .padding()
                    .glassBackgroundEffect()
                }
                
                ImageWithCache(planet: planet)
            }
        }
        .navigationTitle("Gallery")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .padding(.horizontal)
        .ornament(
            visibility: .visible,
            attachmentAnchor: .scene(.bottom),
            contentAlignment: .bottom) {
                Button {
                    openWindow(id: Constant.WindowId.planetWindowId)
                } label: {
                    Text("View 3D Model")
                        .padding()
                }
                .glassBackgroundEffect(
                    in: RoundedRectangle(
                        cornerRadius: 32,
                        style: .continuous
                    )
                )
                .opacity(supportsMultipleWindows ? 1 : 0)
            }
        .onAppear {
            for planet in planets {
                planet.isSelected = planet.id == self.planet.id
            }
        }
        .onDisappear {
            dismissWindow(id: Constant.WindowId.planetWindowId)
        }
    }
    
    private func splitSentences(from paragraph: String) -> [String] {
        var sentences = [String]()
        let tokenizer = NLTokenizer(unit: .sentence)
        tokenizer.string = paragraph
        tokenizer.enumerateTokens(in: paragraph.startIndex..<paragraph.endIndex) { range, _ in
            let sentence = String(paragraph[range]).trimmingCharacters(in: .whitespacesAndNewlines)
            sentences.append(sentence)
            return true
        }
        return sentences
    }
}


#Preview {
    PlanetDetailView(planet: PlanetModelPersistence(name: "Earth", index: 3, fact: "Earth is the third planet from the Sun and the only known planet to support life. It has a diameter of approximately 12,742 km and is composed primarily of rock and metal. The Earth has a dense atmosphere that protects life on the planet and helps regulate the surface temperature. It has a magnetic field that protects the planet from harmful solar and cosmic radiation. The planet is approximately 4.54 billion years old and has a diverse array of habitats, including oceans, forests, deserts, and tundras. Life on Earth has evolved over millions of years, leading to the development of diverse species, including humans."))
}
