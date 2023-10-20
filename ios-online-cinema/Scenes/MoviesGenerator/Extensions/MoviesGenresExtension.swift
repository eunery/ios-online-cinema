//
//  MoviesGenresExtension.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 20.10.2023.
//

import Foundation
import UIKit

extension MoviesGeneratorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validateFields()
    }
}

extension MoviesGeneratorViewController: GenrePickerViewControllerDelegate {
    func selectData(text: String) {
        self.viewModel.setGenre(genre: text)
        self.genreButton.setTitle(text, for: .normal)
        self.validateFields()
    }
}
