//
//  MoviesFeedViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesFeedViewModel: MoviesFeedViewModelProtocol {
    var isLoading: Bool = false
    var error: String?
    var movies: TrendMoviesViewControllerModel?
    var fetchedMovies: TrendMoviesResponseModel?
    var genres: [Int: String] = [Int: String]()
    let service = APIService(worker: NetworkWorker())
    let fetchMoviesGroup = DispatchGroup()
    let queueMovies = DispatchQueue(label: "queueMovies")
    let queueGenres = DispatchQueue(label: "queueGenres")

    func fetch(completionHandler: @escaping () -> Void) {
        self.isLoading = true
        getGenres()
        getMovies()
        fetchMoviesGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            guard let fetchedMovies = self.fetchedMovies else { return }
            var genresString: [String] = [String]()
            self.movies = TrendMoviesViewControllerModel(
                page: fetchedMovies.page,
                results: fetchedMovies.results.map {
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
                },
                totalPages: fetchedMovies.totalPages,
                totalResults: fetchedMovies.totalResults
            )
            self.isLoading = false
            completionHandler()
        }
    }
    
    func getGenres() {
        self.fetchMoviesGroup.enter()
        self.service.getMoviesGenres { result in
            self.queueGenres.async(group: self.fetchMoviesGroup) { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    self.error = error.localizedDescription
                case .success(let response):
                    for item in response.genres {
                        self.genres[item.id] = item.name
                    }
                }
                self.fetchMoviesGroup.leave()
            }
        }
    }
    
    func getMovies() {
        self.fetchMoviesGroup.enter()
        self.service.getTrendingMovies { result in
            self.queueMovies.async(group: self.fetchMoviesGroup) { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    self.error = error.localizedDescription
                case .success(let response):
                    self.fetchedMovies = response
                }
                self.fetchMoviesGroup.leave()
            }
        }
    }
}
