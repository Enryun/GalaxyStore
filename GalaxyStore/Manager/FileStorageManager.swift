//
//  FileStorageManager.swift
//  GalaxyStore
//
//  Created by ThangDDB on 10/03/2024.
//

import Foundation

@Observable
final class FileStorageManager: FileStorageManaging {

    init() {}
    
    func saveFile(fileName: String, fileData: Data) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        // Checks if file exists, removes it if so
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old USDZ file")
            } catch let removeError {
                print("Couldn't remove file at path: \(removeError)")
            }
        }
        
        do {
            try fileData.write(to: fileURL)
            print("USDZ file saved successfully")
        } catch let error {
            print("Error saving USDZ file: \(error)")
        }
    }
    
    func loadFileFromDiskWith(fileName: String) -> URL? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let fileUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            return fileUrl
        }
        
        return nil
    }
}
