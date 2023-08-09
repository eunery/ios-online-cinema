//
//  FavouriteMoviesViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit

class FavouriteMoviesViewController : UIViewController {
    
    let viewModel: FavouriteMoviesViewModel
    
    init(viewModel: FavouriteMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.fetch()
        view.backgroundColor = .yellow
    }
    
    func bindViewModel() {
        viewModel.title.bind { [weak self] title in
            guard let self else { return }
            DispatchQueue.main.async {
                self.title = title
            }
        }
    }
}
