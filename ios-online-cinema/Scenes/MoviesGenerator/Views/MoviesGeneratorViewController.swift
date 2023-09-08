//
//  MoviesGeneratorViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 08.09.2023.
//

import Foundation
import UIKit

class MoviesGeneratorViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: MoviesGeneratorViewModelProtocol
    var coordinator: MoviesGeneratorCoordinatorProtocol?
    
    let genreLabel = UILabel()
    let genreTextView = UITextView()
    let genreMenu = UIMenu()
    let yearLabel = UILabel()
    let yearTextView = UITextView()
    let yearPicker = UIPickerView()
    let generateButton = UIButton()
    
    // MARK: - Init
    
    init(viewModel: MoviesGeneratorViewModelProtocol) {
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
        self.view.addSubview(genreLabel)
        self.view.addSubview(genreTextView)
        self.view.addSubview(yearLabel)
        self.view.addSubview(yearTextView)
        
        setupUI()
        setupLayout()
        yearPickerViewSetup()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        genreLabel.text = "Choose genre"
        genreLabel.font = ProximaNovaFont.font(type: .bold, size: 22)
        genreLabel.textAlignment = .center
        genreTextView.backgroundColor = .systemGray6
        genreTextView.isEditable = false
        genreTextView.text = "Genre"
        genreTextView.textColor = .black
        genreTextView.layer.cornerRadius = 10
        genreTextView.font = ProximaNovaFont.font(type: .regular, size: 20)
        genreTextView.textAlignment = .center
        yearLabel.text = "Pick a year"
        yearLabel.font = ProximaNovaFont.font(type: .bold, size: 22)
        yearLabel.textAlignment = .center
        yearTextView.inputView = yearPicker
        yearTextView.backgroundColor = .systemGray6
        yearTextView.isEditable = false
        yearTextView.textColor = .black
        yearTextView.layer.cornerRadius = 10
        yearTextView.font = ProximaNovaFont.font(type: .regular, size: 20)
        yearTextView.textAlignment = .center
    }
    
    func setupLayout() {
        genreLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(80)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(80)
        }
        
        genreTextView.snp.makeConstraints { maker in
            maker.leading.equalTo(genreLabel)
            maker.top.equalTo(genreLabel.snp.bottom).offset(6)
            maker.trailing.equalTo(genreLabel)
            maker.height.greaterThanOrEqualTo(40)
        }
        
        yearLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(genreLabel)
            maker.top.equalTo(genreTextView.snp.bottom).offset(20)
            maker.trailing.equalTo(genreLabel)
        }
        
        yearTextView.snp.makeConstraints { maker in
            maker.leading.equalTo(genreLabel)
            maker.top.equalTo(yearLabel.snp.bottom).offset(6)
            maker.trailing.equalTo(genreLabel)
            maker.height.greaterThanOrEqualTo(40)
        }
    }
    
    func yearPickerViewSetup() {
        yearPicker.delegate = self
        yearPicker.dataSource = self
    }
}

extension MoviesGeneratorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.yearsArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.yearsArray[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearTextView.text = self.viewModel.yearsArray[row].description
        yearTextView.resignFirstResponder()
    }
}
