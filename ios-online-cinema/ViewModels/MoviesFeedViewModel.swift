//
//  MoviesFeedViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesFeedViewModel: ObservableObject {
    var movies: Dynamic<TrendMoviesResponseModel?> = Dynamic(nil)
    var genres: Dynamic<Dictionary<Int,String>> = Dynamic(Dictionary<Int, String>())
    var error: Dynamic<String?> = Dynamic(String())
    let service = APIService()
    var isLoading: Dynamic<Bool> = Dynamic(false)
    
    
    #warning("TODO: make dispatch group for several api calls")
    func fetch() {
        self.isLoading.value = true
        getGenres()
        service.getTrendingMovies(url: service.urlTrends) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    self.error.value = error.localizedDescription
                case .success(let response):
                    self.movies.value = response
                }
            }
        }
    }
    
    func getGenres() {
        service.getMoviesGenres(url: service.urlGenres) {  result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    self.error.value = error.localizedDescription
                case .success(let response):
                    for item in response.genres {
                        self.genres.value[item.id] = item.name
                    }
                }
            }
            
        }
    }
}
