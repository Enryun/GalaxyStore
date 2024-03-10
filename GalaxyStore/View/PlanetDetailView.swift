//
//  PlanetDetail.swift
//  GalaxyStore
//
//  Created by ThangDDB on 09/03/2024.
//

import SwiftUI
import NaturalLanguage

struct PlanetDetailView: View {
    
    let card: PlanetModel
    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                VStack(spacing: 24) {
                    Text(card.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(splitSentences(from: card.fact), id: \.self) { sentence in
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
                
                
                Image(card.name, bundle: .main)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
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
                    openWindow(id: "Earth")
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
    PlanetDetailView(card: defaultCards[0])
}
