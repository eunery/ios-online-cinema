//
//  MovieCollectionViewCell.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 05.08.2023.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "MovieCell"
    
    var id: Int?
    var posterView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var genreLabel: UILabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setup() {
        self.contentView.addSubview(posterView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(genreLabel)
        
        setupUI()
        setupLayout()
    }
    
    func setupLayout() {
        posterView.snp.makeConstraints { maker in
            maker.leading.equalTo(contentView)
            maker.top.equalTo(contentView)
            maker.trailing.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(posterView.snp.leading)
            maker.top.equalTo(posterView.snp.bottom)
            maker.trailing.equalTo(contentView)
        }
        
        genreLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel.snp.leading)
            maker.top.equalTo(titleLabel.snp.bottom)
            maker.trailing.equalTo(contentView)
            maker.bottom.equalTo(contentView)
        }
    }
    
    func setupUI() {
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 8
        posterView.contentMode = .scaleAspectFill
        titleLabel.font = ProximaNovaFont.font(type: .bold, size: 14)
        genreLabel.font = ProximaNovaFont.font(type: .regular, size: 12)
    }
    
    func configure(cellModel: MovieCollectionViewCellModel) {
        self.posterView.sd_setImage(with: URL(string: cellModel.poster), placeholderImage: UIImage(named: "noimage"))
        self.id = cellModel.id
        self.titleLabel.text = cellModel.title
        self.genreLabel.text = cellModel.genre
    }
}
