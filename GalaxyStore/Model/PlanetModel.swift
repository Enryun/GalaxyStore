//
//  Card.swift
//  GalaxyStore
//
//  Created by ThangDDB on 09/03/2024.
//

import Foundation

struct PlanetModel: Identifiable, Equatable, Hashable, Codable {
    var id: String
    var name: String
    var fact: String
    var imageUrl: String
    var assetUrl: String
    
    var localImageURL: String {
        return self.id + "." + Constant.FileType.png
    }
}
