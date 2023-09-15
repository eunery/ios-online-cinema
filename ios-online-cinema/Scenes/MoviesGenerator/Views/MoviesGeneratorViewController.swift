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
    let genreTextField = UITextField()
    let yearLabel = UILabel()
    let yearTextField = UITextField()
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
        self.view.addSubview(genreTextField)
        self.view.addSubview(yearLabel)
        self.view.addSubview(yearTextField)
        self.view.addSubview(generateButton)
        
        setupUI()
        setupLayout()
        yearPickerViewSetup()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        genreLabel.text = "Choose genre"
        genreLabel.font = ProximaNovaFont.font(type: .bold, size: 22)
        genreLabel.textAlignment = .center
        
        genreTextField.backgroundColor = .systemGray6
        genreTextField.textColor = .black
        genreTextField.text = ""
        genreTextField.layer.cornerRadius = 10
        genreTextField.font = ProximaNovaFont.font(type: .regular, size: 20)
        genreTextField.textAlignment = .center
        genreTextField.addTarget(self, action: #selector(self.getGenresMenu), for: .touchDown)
        genreTextField.delegate = self
        
        yearLabel.text = "Pick a year"
        yearLabel.font = ProximaNovaFont.font(type: .bold, size: 22)
        yearLabel.textAlignment = .center
        
        yearTextField.inputView = yearPicker
        yearTextField.backgroundColor = .systemGray6
        yearTextField.textColor = .black
        yearTextField.layer.cornerRadius = 10
        yearTextField.font = ProximaNovaFont.font(type: .regular, size: 20)
        yearTextField.textAlignment = .center
        yearTextField.addTarget(self, action: #selector(self.validateFields), for: .valueChanged)
        yearTextField.delegate = self
        
        generateButton.setTitle("Generate!", for: .disabled)
        generateButton.setTitleColor(.white, for: .disabled)
        generateButton.setTitle("Generate!", for: .normal)
        generateButton.setTitleColor(.white, for: .normal)
        generateButton.backgroundColor = .systemPink
        generateButton.titleLabel?.font = ProximaNovaFont.font(type: .regular, size: 20)
        generateButton.layer.cornerRadius = 10
        setButtonState(isEnabled: false)
        
    }
    
    func setupLayout() {
        genreLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(80)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(80)
        }
        
        genreTextField.snp.makeConstraints { maker in
            maker.leading.equalTo(genreLabel)
            maker.top.equalTo(genreLabel.snp.bottom).offset(6)
            maker.trailing.equalTo(genreLabel)
            maker.height.greaterThanOrEqualTo(40)
        }
        
        yearLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(genreLabel)
            maker.top.equalTo(genreTextField.snp.bottom).offset(20)
            maker.trailing.equalTo(genreLabel)
        }
        
        yearTextField.snp.makeConstraints { maker in
            maker.leading.equalTo(genreLabel)
            maker.top.equalTo(yearLabel.snp.bottom).offset(6)
            maker.trailing.equalTo(genreLabel)
            maker.height.greaterThanOrEqualTo(40)
        }
        
        generateButton.snp.makeConstraints { maker in
            maker.leading.equalTo(genreLabel)
            maker.top.equalTo(yearTextField.snp.bottom).offset(40)
            maker.trailing.equalTo(genreLabel)
            maker.height.greaterThanOrEqualTo(40)
        }
    }
    
    func yearPickerViewSetup() {
        yearPicker.delegate = self
        yearPicker.dataSource = self
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setButtonState(isEnabled: Bool) {
        if isEnabled {
            generateButton.alpha = 1
            generateButton.isEnabled = true
        } else {
            generateButton.isEnabled = false
            generateButton.alpha = 0.4
        }
    }
    
    @objc func getGenresMenu() {
        let viewController = GenrePickerViewController()
        viewController.actions = self
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(viewController, animated: true)
        self.viewModel.start { result in
            switch result {
            case .failure(let error):
                self.showError(error: error)
            case .success(()): break

            }
        }
    }
    
    @objc func validateFields() {
        if !(genreTextField.text?.isEmpty ?? true) && !(yearTextField.text?.isEmpty ?? true) {
            setButtonState(isEnabled: true)
        } else {
            setButtonState(isEnabled: false)
        }
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
        yearTextField.text = self.viewModel.yearsArray[row].description
        yearTextField.resignFirstResponder()
    }
}

extension MoviesGeneratorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validateFields()
    }
}

extension MoviesGeneratorViewController: GenrePickerViewControllerDelegate {
    func selectData(text: String) {
        self.genreTextField.text = text
        self.validateFields()
    }
}
