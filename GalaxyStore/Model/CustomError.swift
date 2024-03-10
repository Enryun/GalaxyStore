//
//  LoadJsonError.swift
//  GalaxyStore
//
//  Created by ThangDDB on 10/03/2024.
//

import Foundation

enum LoadJsonError: Error {
    case CannotFind
    case CannotLoad
    case CannotParse
}

