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
    
    weak var actions: GenrePickerViewControllerDelegate?
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let test = Array(1...30)
    
    // MARK: - Init
    
    init() {
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

extension GenrePickerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let item = test[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GenrePickerTableViewCell.identifier,
            for: indexPath) as? GenrePickerTableViewCell else { return UITableViewCell() }
        cell.genreName.text = "test" + item.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GenrePickerTableViewCell {
            guard let item = cell.genreName.text else { return }
            self.actions?.selectData(text: item)
            self.dismiss(animated: true)
        }
        
    }
}

extension GenrePickerViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
}
