//
//  MoviesFeedViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesFeedViewModel: ObservableObject {
    let service = APIService()
    var movies: Dynamic<TrendMoviesViewControllerModel?> = Dynamic(nil)
    var error: Dynamic<String?> = Dynamic(String())
    var isLoading: Dynamic<Bool> = Dynamic(false)
    
    var fetchedMovies: TrendMoviesResponseModel? = nil
    var genres: Dictionary<Int,String> = Dictionary<Int, String>()

    func fetch() {
        self.isLoading.value = true
        
        let fetchMoviesGroup = DispatchGroup()
        let queueMovies = DispatchQueue(label: "queueMovies")
        let queueGenres = DispatchQueue(label: "queueGenres")
        
        fetchMoviesGroup.enter()
        service.getMoviesGenres(url: service.urlGenres) {  result in
            queueGenres.async(group: fetchMoviesGroup) { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    self.error.value = error.localizedDescription
                case .success(let response):
                    for item in response.genres {
                        self.genres[item.id] = item.name
                    }
                }
                fetchMoviesGroup.leave()
            }
        }
        fetchMoviesGroup.enter()
        service.getTrendingMovies(url: service.urlTrends) { result in
                queueMovies.async(group: fetchMoviesGroup) { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    print(error)
                    self.error.value = error.localizedDescription.description
                case .success(let response):
                    self.fetchedMovies = response
                }
                    fetchMoviesGroup.leave()
            }
        }
        
        fetchMoviesGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            var genresString: [String] = [String]()
            self.movies.value = TrendMoviesViewControllerModel(
                page: self.fetchedMovies!.page,
                results: self.fetchedMovies?.results.map {
                    genresString.removeAll()
                    for item in $0.genreIds {
                        genresString.append(self.genres[item] ?? "")
                    }
                    return MovieShortViewControllerModel(
                        adult: $0.adult,
                        backdropPath: $0.backdropPath,
                        id: $0.id,
                        title: $0.title,
                        originalLanguage: $0.originalLanguage,
                        originalTitle: $0.originalTitle,
                        overview: $0.overview,
                        posterPath: $0.posterPath,
                        mediaType: $0.mediaType,
                        genreStrings: genresString,
                        popularity: $0.popularity,
                        releaseDate: $0.releaseDate,
                        video: $0.video,
                        voteAverage: $0.voteAverage,
                        voteCount: $0.voteCount
                    )
                } as! [MovieShortViewControllerModel],
                totalPages: self.fetchedMovies!.totalPages,
                totalResults: self.fetchedMovies!.totalResults
            )
        }
    }
}
