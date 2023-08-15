//
//  MoviesDetailsViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit
import SDWebImage

class MoviesDetailsViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    let viewModel: MoviesDetailsViewModelProtocol
    
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let loader = UIActivityIndicatorView()
    let posterView = UIView()
    var poster = UIImageView()
    let header = UILabel()
    let stackView = UIStackView()
    let genre = UILabel()
    let vote = UILabel()
    let date = UILabel()
    let overview = UILabel()
    
    
    init(viewModel: MoviesDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetch(movieId: 35) {
            guard let movie = self.viewModel.movie else { return }
            self.handleLoadingIndication(isLoading: self.viewModel.isLoading)
            let host = "image.tmdb.org"
            let scheme = "https"
            let path = "/t/p/w500"
            var url = URLComponents()
            url.scheme = scheme
            url.host = host
            url.path = path + movie.posterPath
            self.poster.sd_setImage(with: url.url)
            self.header.text = movie.title
            self.vote.text = movie.voteAverage.description
            self.date.text = String(movie.releaseDate.prefix(4))
            var tempArray = movie.genres.map {
                $0.name
            }
            self.genre.text = tempArray.formatted()
            self.overview.text = movie.overview
        }
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        view.addSubview(loader)
        loader.hidesWhenStopped = true
        loader.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        self.handleLoadingIndication(isLoading: self.viewModel.isLoading)
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalTo(self.view)
        }
        
        scrollView.addSubview(posterView)
        posterView.clipsToBounds = false
        posterView.layer.shadowColor = UIColor.black.cgColor
        posterView.layer.shadowOpacity = 1
        posterView.layer.shadowOffset = CGSize(width: 0, height: 5)
        posterView.layer.shadowRadius = 10
        posterView.layer.cornerRadius = 10
//        posterView.layer.shadowPath = UIBezierPath(roundedRect: posterView.bounds, cornerRadius: 10).cgPath
        posterView.snp.makeConstraints { maker in
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            maker.top.equalTo(self.view.snp.top)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            maker.height.equalTo(UIScreen.main.bounds.height/2)
        }
        
        posterView.addSubview(poster)
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 26
        poster.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.snp.makeConstraints { maker in
            
            maker.leading.equalTo(posterView).inset(10)
            maker.top.equalTo(posterView.snp.bottom).offset(14)
            maker.trailing.equalTo(posterView).inset(10)
        }
        
        stackView.addArrangedSubview(genre)
        genre.font = ProximaNovaFont.font(type: .bold, size: 14)
        genre.textAlignment = .center
        genre.numberOfLines = 0
        
        stackView.addArrangedSubview(vote)
        vote.font = ProximaNovaFont.font(type: .bold, size: 16)
        vote.textAlignment = .center
        
        stackView.addArrangedSubview(date)
        date.font = ProximaNovaFont.font(type: .bold, size: 14)
        date.textAlignment = .center
        
        scrollView.addSubview(header)
        header.font = ProximaNovaFont.font(type: .bold, size: 24)
        header.snp.makeConstraints { maker in
            maker.leading.equalTo(stackView)
            maker.top.equalTo(stackView.snp.bottom).offset(14)
            maker.trailing.equalTo(stackView)
        }

        scrollView.addSubview(overview)
        overview.numberOfLines = 0
        overview.font = ProximaNovaFont.font(type: .regular, size: 18)
        overview.snp.makeConstraints { maker in
            maker.leading.equalTo(header)
            maker.top.equalTo(header.snp.bottom).offset(16)
            maker.trailing.equalTo(header)
        }

    }
    
    func handleLoadingIndication(isLoading: Bool) {
        if isLoading {
            self.loader.startAnimating()
        } else {
            self.loader.stopAnimating()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
