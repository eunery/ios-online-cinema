//
//  MovieTitleOverviewTableViewCell.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 16.08.2023.
//

import Foundation
import UIKit

class MovieTitleOverviewTableViewCell: UITableViewCell {
    static let identifier: String = "MovieTitleOverviewCell"
    
    var header = UILabel()
    var overview = UILabel()
    var button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        self.contentView.addSubview(header)
        header.font = ProximaNovaFont.font(type: .bold, size: 24)
        header.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(10)
            maker.trailing.equalToSuperview().inset(10)
        }

        self.contentView.addSubview(overview)
        overview.numberOfLines = 0
        overview.font = ProximaNovaFont.font(type: .regular, size: 18)
        overview.snp.makeConstraints { maker in
            maker.leading.equalTo(header)
            maker.top.equalTo(header.snp.bottom).offset(16)
            maker.trailing.equalTo(header)
        }
        
        self.contentView.addSubview(button)
        button.backgroundColor = .red
        button.setTitle("Add to favourites", for: .normal)
        button.layer.cornerRadius = 10
        button.snp.makeConstraints { maker in
            maker.leading.equalTo(header)
            maker.top.equalTo(overview.snp.bottom).offset(10)
            maker.trailing.equalTo(header)
        }
    }
    
    func configure(cell: MovieDetailsTableViewCellModel?) {
        guard let cell = cell else { return }
        self.header.text = cell.title
        self.overview.text = cell.overview
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
