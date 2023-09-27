//
//  SceneError.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 27.09.2023.
//

import Foundation

enum MoviesGeneratorError: Error, LocalizedError {
    case generationError
        
    var errorDescription: String? {
        
        switch self {
        case .generationError:
            return "Не удалось сгенерировать фильм."
        }
    }
}
