//
//  CoreDataError.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 06.09.2023.
//

import Foundation

enum CoreDataError: Error, LocalizedError {
    case dublicate
    case fetchError
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .dublicate:
            return "Found dublicate inside DB."
        case .fetchError:
            return "Found error while fetching data."
        case .notFound:
            return "Item not found."
        }
    }
}
