//
//  FileStorageManaging.swift
//  GalaxyStore
//
//  Created by ThangDDB on 10/03/2024.
//

import Foundation

protocol FileStorageManaging {
    func saveFile(fileName: String, fileData: Data)
    func loadFileFromDiskWith(fileName: String) -> URL?
}
