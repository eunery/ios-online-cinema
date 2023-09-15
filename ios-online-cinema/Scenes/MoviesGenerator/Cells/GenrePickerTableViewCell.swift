//
//  GenrePickerTableViewCell.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 15.09.2023.
//

import Foundation
import UIKit

class GenrePickerTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "GenrePickerCell"
    let genreName = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setup() {
        self.contentView.addSubview(genreName)
        
        setupUI()
        setupLayout()
    }
    
    func setupUI() {
        
    }
    
    func setupLayout() {
        genreName.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
            maker.height.lessThanOrEqualTo(40)
        }
    }
}
