//
//  PlanetModelPersistence.swift
//  GalaxyStore
//
//  Created by ThangDDB on 10/03/2024.
//

import Foundation
import SwiftData

@Model
class PlanetModelPersistence: Identifiable, Equatable {
    @Attribute(.unique) var id: String
    var name: String
    var index: Int
    var fact: String
    var isSelected: Bool
    
    var localImageURL: String {
        return self.id + "." + Constant.FileType.png
    }
    
    var localObjectURL: String {
        return self.id + "." + Constant.FileType.usdz
    }
    
    init( name: String, index: Int, fact: String) {
        self.id = UUID().uuidString
        self.name = name
        self.index = index
        self.fact = fact
        self.isSelected = false
    }
}
