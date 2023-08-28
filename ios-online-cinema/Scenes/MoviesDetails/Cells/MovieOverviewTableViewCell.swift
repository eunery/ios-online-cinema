//
//  MovieOverviewTableViewCell.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 16.08.2023.
//

import Foundation
import UIKit

class MovieOverviewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "MovieTitleOverviewCell"
    
    var headerLabel = UILabel()
    var overviewLabel = UILabel()
    
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
        self.contentView.addSubview(headerLabel)
        self.contentView.addSubview(overviewLabel)
        
        setupUI()
        setupLayout()
    }
    
    func setupUI() {
        headerLabel.font = ProximaNovaFont.font(type: .bold, size: 24)
        headerLabel.numberOfLines = 0
        overviewLabel.numberOfLines = 0
        overviewLabel.font = ProximaNovaFont.font(type: .regular, size: 18)
    }
    
    func setupLayout() {
        headerLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(10)
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview().inset(10)
        }
        overviewLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(self.headerLabel)
            maker.top.equalTo(self.headerLabel.snp.bottom).offset(16)
            maker.trailing.equalTo(self.headerLabel)
            maker.bottom.equalToSuperview()
        }
    }
    
    func configure(cellModel: MoviesDetailsOverviewCellData) {
        self.headerLabel.text = cellModel.title
        self.overviewLabel.text = cellModel.overview
    }
}
