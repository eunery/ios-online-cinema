//
//  MoviesFeedViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit
import SnapKit
import SDWebImage

class MoviesFeedViewController : UIViewController, Coordinating{
    
    var coordinator: Coordinator?
    var viewModel: MoviesFeedViewModelProtocol
    
    let main = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let container = UIView()
    let loader = UIActivityIndicatorView()
    let headerLabel = UILabel()
    let moviesFeedCollectionView = UICollectionView(frame: .zero,
                                                    collectionViewLayout: UICollectionViewFlowLayout())
    let refreshControl = UIRefreshControl()
    var currentPage = 1
    
    init(viewModel: MoviesFeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetch(page: nil) {
            self.moviesFeedCollectionView.reloadData()
            self.handleLoadingIndication(isLoading: self.viewModel.isLoading)
            self.currentPage += 1
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
        
        view.addSubview(main)
        main.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
            
        }
        
        main.addSubview(container)
        container.snp.makeConstraints { maker in
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
        }
        
        headerLabel.text = "Trending movies today"
        headerLabel.font = ProximaNovaFont.font(type: .extraBold, size: 28)
        container.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        moviesFeedCollectionView.frame = container.bounds
        container.addSubview(moviesFeedCollectionView)
        moviesFeedCollectionView.snp.makeConstraints { maker in
            maker.leading.equalTo(container)
            maker.top.equalTo(headerLabel.snp.bottom).offset(14)
            maker.trailing.equalTo(container)
            maker.bottom.equalTo(container)
            
        }
        moviesFeedCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        moviesFeedCollectionView.dataSource = self
        moviesFeedCollectionView.delegate = self
        moviesFeedCollectionView.backgroundColor = .none
    }
    
    func loadData() {
        self.viewModel.fetch(page: self.viewModel.page) {
            self.handleLoadingIndication(isLoading: self.viewModel.isLoading)
            self.moviesFeedCollectionView.performBatchUpdates({
                let indexPath = IndexPath(row: self.viewModel.dataSource.count, section: 0)
                self.moviesFeedCollectionView.insertItems(at: [indexPath])
                
            })
        }
        self.currentPage += 1
    }
    
    func handleLoadingIndication(isLoading: Bool) {
        if isLoading {
            self.loader.startAnimating()
        } else {
            self.loader.stopAnimating()
        }
    }
}

extension MoviesFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell
        cell?.configure(cell: self.viewModel.dataSource[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow: CGFloat = 2
        let padding: CGFloat = 10
        let cellWidth = (collectionView.bounds.width / cellsPerRow) - padding
        let cellHeight: CGFloat = 286
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == self.viewModel.dataSource.count - 1, self.currentPage < self.viewModel.totalPages {
            self.viewModel.fetch(page: self.currentPage) {
                collectionView.reloadData()
                self.handleLoadingIndication(isLoading: self.viewModel.isLoading)
            }
            self.currentPage += 1
        }
    }
}
