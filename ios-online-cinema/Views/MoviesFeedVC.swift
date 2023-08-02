//
//  MoviesFeedVC.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit
import SnapKit

class MoviesFeedVC : UIViewController, Coordinating{
    
    var coordinator: Coordinator?
    var viewModel = MoviesFeedVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.fetch()
        view.backgroundColor = .systemPink
    }
    
    func bindViewModel() {
        viewModel.title.bind { [weak self] title in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.title = title
            }
        }
    }
}
