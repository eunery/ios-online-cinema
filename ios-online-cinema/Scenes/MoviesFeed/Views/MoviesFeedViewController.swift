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
    let viewModel: MoviesFeedViewModelProtocol
    
    let main = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let container = UIView()
    let loader = UIActivityIndicatorView()
    let headerLabel = UILabel()
    let moviesFeedCollectionView = UICollectionView(frame: .zero,
                                                    collectionViewLayout: UICollectionViewFlowLayout())
    let refreshControl = UIRefreshControl()
    
    init(viewModel: MoviesFeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetch {
            self.moviesFeedCollectionView.reloadData()
            self.handleLoadingIndication(isLoading: self.viewModel.isLoading)
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
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        moviesFeedCollectionView.refreshControl = refreshControl
    }
    
    @objc func loadData() {
        
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
        return self.viewModel.movies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell
        let poster = self.viewModel.movies?.results[indexPath.row].posterPath.description
        let host = "image.tmdb.org"
        let scheme = "https"
        let path = "/t/p/w500"
        var ttt = URLComponents()
        ttt.scheme = scheme
        ttt.host = host
        ttt.path = path + poster!
        cell?.poster.sd_setImage(with: ttt.url)
        cell?.title.text = self.viewModel.movies?.results[indexPath.item].title
        cell?.genre.text = self.viewModel.movies?.results[indexPath.item].genreStrings.formatted()
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow: CGFloat = 2
        let padding: CGFloat = 10
        let cellWidth = (collectionView.bounds.width / cellsPerRow) - padding
//        let cellHeight = collectionView.frame.height - (2 * padding) / 2
        let cellHeight: CGFloat = 286
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

