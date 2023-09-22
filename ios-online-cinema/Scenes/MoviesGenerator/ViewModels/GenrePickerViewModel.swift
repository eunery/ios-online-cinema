//
//  GenrePickerViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 22.09.2023.
//

import Foundation

class GenrePickerViewModel: GenrePickerViewModelProtocol {
    
    // MARK: - Properties
    
    var genresNames: [String] = [String]()
    
    // MARK: - Methods
    
    func filterGenres(searchText: String) -> [String] {
        return searchText.isEmpty ? genresNames : genresNames.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
    }
}
