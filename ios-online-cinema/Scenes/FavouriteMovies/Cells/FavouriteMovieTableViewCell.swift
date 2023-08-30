//
//  FavouriteMovieTableViewCell.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 28.08.2023.
//

import Foundation
import UIKit

class FavouriteMovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "FavouriteMovieCell"
    var id: Int?
    var posterView = UIImageView()
    var genreLabel: UILabel = UILabel()
    var voteLabel: UILabel = UILabel()
    var releaseDateLabel: UILabel = UILabel()
    var titleLabel: UILabel = UILabel()
    var overviewLabel: UILabel = UILabel()
    
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
        self.contentView.addSubview(genreLabel)
        self.contentView.addSubview(voteLabel)
        self.contentView.addSubview(releaseDateLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(overviewLabel)
        
        setupUI()
        setupLayout()
    }
    
    func setupUI() {
        self.selectionStyle = .none
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 8
        posterView.contentMode = .scaleAspectFill
        titleLabel.font = ProximaNovaFont.font(type: .bold, size: 16)
        overviewLabel.font = ProximaNovaFont.font(type: .regular, size: 14)
        overviewLabel.numberOfLines = 0
        genreLabel.font = ProximaNovaFont.font(type: .regular, size: 14)
        voteLabel.font = ProximaNovaFont.font(type: .regular, size: 14)
        releaseDateLabel.font = ProximaNovaFont.font(type: .regular, size: 14)
    }
    
    func setupLayout() {
        posterView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview().inset(5)
            maker.bottom.equalToSuperview().inset(5)
            maker.width.equalTo(120)
            maker.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(posterView.snp.trailing).offset(8)
            maker.top.equalTo(posterView.snp.top)
        }
        
        voteLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel)
            maker.top.equalTo(titleLabel.snp.bottom).offset(4)
            maker.trailing.equalToSuperview()
        }
        
        releaseDateLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel)
            maker.top.equalTo(voteLabel.snp.bottom).offset(4)
            maker.trailing.equalToSuperview()
        }
        
        genreLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel)
            maker.top.equalTo(releaseDateLabel.snp.bottom).offset(4)
            maker.trailing.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel)
            maker.top.equalTo(genreLabel.snp.bottom).offset(4)
            maker.trailing.equalToSuperview()
            maker.bottom.equalTo(posterView.snp.bottom)
        }
    }
    
    func configure(cellModel: Movie) {
        self.id = cellModel.id
        self.posterView.sd_setImage(with: URL(string: cellModel.poster))
        self.genreLabel.text = cellModel.genres
        self.voteLabel.text = cellModel.vote
        self.releaseDateLabel.text = cellModel.releaseDate
        self.titleLabel.text = cellModel.title
        self.overviewLabel.text = cellModel.overview
    }
}
