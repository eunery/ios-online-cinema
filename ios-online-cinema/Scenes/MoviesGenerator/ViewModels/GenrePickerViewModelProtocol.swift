//
//  GenrePickerViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 22.09.2023.
//

import Foundation

protocol GenrePickerViewModelProtocol {
    var genresNames: [String] { get set }
    
    func filterGenres(searchText: String) -> [String]
}
