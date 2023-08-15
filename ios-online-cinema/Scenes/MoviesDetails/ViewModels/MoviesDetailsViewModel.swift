//
//  MoviesDetailsViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesDetailsViewModel: MoviesDetailsViewModelProtocol {
    var isLoading: Bool = false
    var error: String?
    var movie: MoviesDetailsModel?
    let service = APIService(worker: NetworkWorker())
    let fetchMovie = DispatchGroup()
    let queueMovie = DispatchQueue(label: "queueMovie")
    
    func fetch(movieId: Int, completionHandler: @escaping () -> Void) {
        self.isLoading = true
        self.fetchMovie.enter()
        service.getMoviesDetails(movieId: movieId) { result in
            self.queueMovie.async(group: self.fetchMovie) { [weak self] in
                switch result {
                case .failure(let error):
                    self?.error = error.localizedDescription
                case .success(let response):
                    self?.movie = response
                }
                self?.fetchMovie.leave()
            }
        }
        self.fetchMovie.notify(queue: .main) { [weak self] in
            guard let self else { return }
            self.isLoading = false
            completionHandler()
        }
    }
}
