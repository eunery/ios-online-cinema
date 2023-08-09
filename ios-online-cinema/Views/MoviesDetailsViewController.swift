//
//  MoviesDetailsViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit

class MoviesDetailsViewController : UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var viewModel: MoviesDetailsViewModel
    
    init(viewModel: MoviesDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.viewModel.fetch()
        self.view.backgroundColor = .systemPink
    }
    
    func bindViewModel() {
        
    }
}
