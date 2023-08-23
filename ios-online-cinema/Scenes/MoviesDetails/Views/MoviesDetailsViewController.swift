//
//  MoviesDetailsViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit
import SDWebImage

class MoviesDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: MoviesDetailsViewModelProtocol
    
    let tableView = UITableView(
        frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    )
    let loader = UIActivityIndicatorView()
    let favouriteButton = UIButton()
    
    // MARK: - Init
    
    init(viewModel: MoviesDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLoadingIndication(isLoading: true)
        self.viewModel.fetch(movieId: self.viewModel.movieId) { result in
            switch result {
            case .failure(let error):
                self.errorDidAppear(error: error)
            case .success(()):
                self.tableView.reloadData()
                self.handleLoadingIndication(isLoading: false)
            }
        }
        setupUI()
    }
    
    // MARK: - Methods
    
    func setupUI() {
        UINavigationBar.appearance().barStyle = .default
        self.view.backgroundColor = .white
        
        view.addSubview(loader)
        loader.hidesWhenStopped = true
        loader.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }

        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    func handleLoadingIndication(isLoading: Bool) {
        if isLoading {
            self.loader.startAnimating()
        } else {
            self.loader.stopAnimating()
        }
    }
    
    func errorDidAppear(error: APIError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MoviesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(MoviePosterTableViewCell.self, forCellReuseIdentifier: MoviePosterTableViewCell.identifier)
        
        switch indexPath.row {
        case 0:
            tableView.register(
                MoviePosterTableViewCell.self, forCellReuseIdentifier: MoviePosterTableViewCell.identifier
            )
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MoviePosterTableViewCell.identifier, for: indexPath
            ) as? MoviePosterTableViewCell
            cell?.configure(cell: self.viewModel.dataSource)
            return cell ?? UITableViewCell()
        case 1:
            tableView.register(
                MovieInfoTableViewCell.self, forCellReuseIdentifier: MovieInfoTableViewCell.identifier
            )
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath
            ) as? MovieInfoTableViewCell
            cell?.configure(cell: self.viewModel.dataSource)
            return cell ?? UITableViewCell()
        case 2:
            tableView.register(
                MovieTitleOverviewTableViewCell.self, forCellReuseIdentifier: MovieTitleOverviewTableViewCell.identifier
            )
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieTitleOverviewTableViewCell.identifier, for: indexPath
            ) as? MovieTitleOverviewTableViewCell
            cell?.configure(cell: self.viewModel.dataSource)
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
