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
    let viewModel: MoviesFeedViewModelProtocol
    
    init(viewModel: MoviesFeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetch()
        self.view.backgroundColor = .systemPink
    }
}
