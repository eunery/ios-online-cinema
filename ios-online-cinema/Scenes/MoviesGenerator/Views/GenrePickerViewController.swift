//
//  GenrePickerViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 15.09.2023.
//

import Foundation
import UIKit

protocol GenrePickerViewControllerDelegate: AnyObject {
    func selectData(text: String)
}

class GenrePickerViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: GenrePickerViewModelProtocol
    weak var delegate: GenrePickerViewControllerDelegate?
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    // MARK: - Init
    
    init(viewModel: GenrePickerViewModelProtocol) {
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
    
    func setup() {
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        setupUI()
        setupLayout()
        setupTableView()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Enter what you looking for.."
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.searchTextField.clearButtonMode = .whileEditing
    }
    
    func setupLayout() {
        searchBar.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(10)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            maker.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { maker in
            maker.leading.equalTo(searchBar)
            maker.top.equalTo(searchBar.snp.bottom).offset(10)
            maker.trailing.equalTo(searchBar)
            maker.bottom.equalToSuperview()
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(GenrePickerTableViewCell.self,
                           forCellReuseIdentifier: GenrePickerTableViewCell.identifier)
    }
}
