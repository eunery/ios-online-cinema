//
//  MoviesDetailsViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit

class MoviesDetailsViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    
    var coordinator: Coordinator?
    let viewModel: MoviesDetailsViewModelProtocol
    
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
        self.viewModel.fetch()
        self.view.backgroundColor = .systemPink
    }
    
    // MARK: - Methods
}
