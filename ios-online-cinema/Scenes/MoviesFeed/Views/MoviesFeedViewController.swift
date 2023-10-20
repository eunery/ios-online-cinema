//
//  MoviesFeedViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit
import SnapKit
import SDWebImage

class MoviesFeedViewController: UIViewController, ShowErrorProtocol {
    
    var coordinator: MoviesFeedCoordinatorProtocol?
    var viewModel: MoviesFeedViewModelProtocol
    
    let loader = UIActivityIndicatorView()
    let headerLabel = UILabel()
    let moviesFeedCollectionView = UICollectionView(frame: .zero,
                                                    collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Init
    
    init(viewModel: MoviesFeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.handleLoadingIndication(isLoading: true)
        self.viewModel.start { result in
            switch result {
            case .failure(let error):
                self.showError(error: error)
            case .success:
                self.moviesFeedCollectionView.reloadData()
                self.handleLoadingIndication(isLoading: false)
                self.viewModel.currentPage += 1
            }
        }
    }
    
    // MARK: - Methods
    
    func setup() {
        
        self.view.addSubview(loader)
        self.view.addSubview(headerLabel)
        self.view.addSubview(moviesFeedCollectionView)
        
        self.setupLayout()
        self.setupUI()
        self.collectionSetup()
    }
    
    func setupLayout() {
        loader.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
        }
        
        moviesFeedCollectionView.frame = headerLabel.bounds
        moviesFeedCollectionView.snp.makeConstraints { maker in
            maker.leading.equalTo(headerLabel)
            maker.top.equalTo(headerLabel.snp.bottom).offset(14)
            maker.trailing.equalTo(headerLabel)
            maker.bottom.equalToSuperview()
        }
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        self.loader.hidesWhenStopped = true
        self.loader.color = .black
        self.loader.style = .large
        self.headerLabel.text = "Trending movies today"
        self.headerLabel.font = ProximaNovaFont.font(type: .extraBold, size: 28)
    }
    
    func collectionSetup() {
        self.moviesFeedCollectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        self.moviesFeedCollectionView.dataSource = self
        self.moviesFeedCollectionView.delegate = self
        self.moviesFeedCollectionView.backgroundColor = .none
    }
    
    func handleLoadingIndication(isLoading: Bool) {
        if isLoading {
            self.loader.startAnimating()
        } else {
            self.loader.stopAnimating()
        }
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
