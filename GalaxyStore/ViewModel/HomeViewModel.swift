//
//  HomeViewModel.swift
//  GalaxyStore
//
//  Created by ThangDDB on 10/03/2024.
//

import Foundation
import SwiftUI

@Observable
final class HomeViewModel {
    
    init() {}
    
    func fetchAllPlanets() throws -> [PlanetModel] {
        do {
            let jsonData: PlanetData = try loadJSONFromDisk("data.json")
            return jsonData.data
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    private func loadJSONFromDisk<T: Decodable>(_ filename: String) throws -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            throw LoadJsonError.CannotFind
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            throw LoadJsonError.CannotLoad
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw LoadJsonError.CannotParse
        }
    }
    
    func fakeFetchImageAndSaveLocalData(planet: PlanetModel, fileManager: FileStorageManager) {
        guard let urlPath = Bundle.main.path(forResource: planet.name, ofType: Constant.FileType.png) else {
            print("Bad URL")
            return
        }
        let localImageURL = URL(fileURLWithPath: urlPath)

        do {
            let imageData = try Data(contentsOf: localImageURL)
            fileManager.saveFile(fileName: planet.localImageURL, fileData: imageData)
        } catch {
            // If there is an error, it typically means the file could not be found or read.
            print("Error loading image data: \(error)")
        }
    }
}
