//
//  FavouriteMoviesViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit

class FavouriteMoviesViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: FavouriteMoviesViewModelProtocol
    var coordinator: FavouriteMoviesCoordinatorProtocol?
    
    let headerLabel = UILabel()
    let tableView = UITableView()
    
    // MARK: - Init
    
    init(viewModel: FavouriteMoviesViewModelProtocol) {
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
    }

    // MARK: - Methods
    
    func setup() {
        self.view.addSubview(headerLabel)
        self.view.addSubview(tableView)
        
        setupUI()
        setupLayout()
        tableViewSetup()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        self.headerLabel.text = "Movie's that you like"
        self.headerLabel.font = ProximaNovaFont.font(type: .extraBold, size: 28)
    }
    
    func setupLayout() {
        headerLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
        }
        
        tableView.frame = headerLabel.bounds
        tableView.snp.makeConstraints { maker in
            maker.leading.equalTo(headerLabel)
            maker.top.equalTo(headerLabel.snp.bottom).offset(14)
            maker.trailing.equalTo(headerLabel)
            maker.bottom.equalToSuperview()
        }
    }
    
    func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(FavouriteMovieTableViewCell.self,
                           forCellReuseIdentifier: FavouriteMovieTableViewCell.identifier)
    }
}

extension FavouriteMoviesViewController: UITableViewDelegate,
                                         UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavouriteMovieTableViewCell.identifier,
        for: indexPath) as? FavouriteMovieTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FavouriteMovieTableViewCell {
            guard let id = cell.id else { return }
            self.coordinator?.showMoviesDetails(movieId: id)
        }
    }
}
