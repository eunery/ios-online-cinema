//
//  MoviesDetailsViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit
import SDWebImage

class MoviesDetailsViewController: UIViewController, ShowErrorProtocol {
    
    // MARK: - Properties
    
    let viewModel: MoviesDetailsViewModelProtocol
    
    let tableView = UITableView()
    let loader = UIActivityIndicatorView()
    
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
        setup()
        handleLoadingIndication(isLoading: true)
        self.viewModel.fetch { result in
            switch result {
            case .failure(let error):
                self.showError(error: error)
            case .success:
                self.tableView.reloadData()
                self.handleLoadingIndication(isLoading: false)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Methods
    
    func setup() {
        self.view.addSubview(loader)
        self.view.addSubview(tableView)
        
        setupUI()
        setupLayout()
        tableViewSetup()
    }
    
    func setupUI() {
        UINavigationBar.appearance().barStyle = .default
        self.view.backgroundColor = .white
        loader.hidesWhenStopped = true
    }
    
    func setupLayout() {
        loader.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        tableView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(
            MoviePosterTableViewCell.self, forCellReuseIdentifier: MoviePosterTableViewCell.identifier
        )
        tableView.register(
            MovieInfoTableViewCell.self, forCellReuseIdentifier: MovieInfoTableViewCell.identifier
        )
        tableView.register(
            MovieOverviewTableViewCell.self, forCellReuseIdentifier: MovieOverviewTableViewCell.identifier
        )
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
