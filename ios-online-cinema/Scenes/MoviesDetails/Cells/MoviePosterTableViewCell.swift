//
//  MoviePosterTableViewCell.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 16.08.2023.
//

import Foundation
import UIKit
import SDWebImage

class MoviePosterTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "MoviePosterCell"
    
    let posterView = UIView()
    let posterImageView = UIImageView()
    
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
        self.contentView.addSubview(posterView)
        posterView.addSubview(posterImageView)
        
        setupUI()
        setupLayout()
    }
    
    func setupUI() {
        posterView.clipsToBounds = false
        posterView.layer.shadowColor = UIColor.black.cgColor
        posterView.layer.shadowOpacity = 1
        posterView.layer.shadowOffset = CGSize(width: 0, height: 5)
        posterView.layer.shadowRadius = 10
        posterView.layer.cornerRadius = 10
        posterView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 26
    }
    
    func setupLayout() {
        posterView.snp.makeConstraints { maker in
            maker.edges.equalTo(contentView)
            maker.height.equalTo(UIScreen.main.bounds.height/2 + 100)
        }
        posterImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    func configure(cellModel: MoviesDetailsPosterCellData) {
        self.posterImageView.sd_setImage(with: URL(string: cellModel.poster))
    }
}
