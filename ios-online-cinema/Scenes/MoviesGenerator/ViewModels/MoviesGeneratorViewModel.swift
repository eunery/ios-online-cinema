//
//  MoviesGeneratorViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 08.09.2023.
//

import Foundation

class MoviesGeneratorViewModel: MoviesGeneratorViewModelProtocol {
    
    // MARK: - Properties
    
    var yearsArray: [Int] = Array(1900...Calendar.current.component(.year, from: .now))
    
    // MARK: - Methods
    
}
