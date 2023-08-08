//
//  MoviesFeedViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit
import SnapKit

class MoviesFeedViewController : UIViewController, Coordinating{
    
    var coordinator: Coordinator?
    var viewModel = MoviesFeedViewModel()
    
    var movies: TrendMoviesViewControllerModel? {
        didSet {
            print(movies)
        }
    }
    var genres: Dictionary<Int, String> = Dictionary<Int, String>()
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.fetch()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("123")
    }
    
    #warning("TODO: make one variable to bind all data")
    func bindViewModel() {
        viewModel.movies.bind { [weak self] movies in
            guard let self else { return }
            DispatchQueue.main.async {
                self.movies = movies
            }
        }
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = isLoading
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemPink
        
        #warning("TODO: make appear when making api call and disappear when api call ends")
        let loader = UIActivityIndicatorView()
        view.addSubview(loader)
        loader.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        loader.startAnimating()
        
        
        let main = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.addSubview(main)
        main.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
            
        }
        let container = UIView()
        main.addSubview(container)
        container.snp.makeConstraints { maker in
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
        }
        let headerLabel = UILabel()
        headerLabel.text = "Trending movies today"
        headerLabel.font = ProximaNovaFont.font(type: .extraBold, size: 28)
        container.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        let moviesFeedCollectionViewFlowLayout = UICollectionViewFlowLayout()
        let moviesFeedCollectionView = UICollectionView(frame: container.bounds, collectionViewLayout: moviesFeedCollectionViewFlowLayout)
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
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        moviesFeedCollectionView.refreshControl = refreshControl
    }
    
    @objc func loadData() {
        print(movies)
    }
    
}

extension MoviesFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.poster.image = resizeImage(image: UIImage(named: "keanu")!, targetSize: CGSize(width: 180, height: 240))
//        cell.title.text = "\(self.movies?.results[indexPath.item])"
//        cell.genre.text = "\(self.movies?.results[indexPath.item].genreStrings)"
        return cell
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
