//
//  MoviesDetailsVM.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesDetailsVM: ObservableObject {
    var title: Dynamic<String> = Dynamic(String())
    
    func fetch() {
        title.value = "Movie Details"
    }
}
