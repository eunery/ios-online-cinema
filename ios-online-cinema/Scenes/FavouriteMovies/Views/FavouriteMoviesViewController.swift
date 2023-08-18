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
    var coordinator: Coordinator?
    
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
        self.viewModel.fetch()
        self.view.backgroundColor = .yellow
    }
    
    // MARK: - Methods
    
}
