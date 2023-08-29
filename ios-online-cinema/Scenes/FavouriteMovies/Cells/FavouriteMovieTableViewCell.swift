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
        let host = "image.tmdb.org"
        let scheme = "https"
        let path = "/t/p/w500"
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = path + "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg"
        posterView.sd_setImage(with: url.url)
        genreLabel.text = "Genres"
        voteLabel.text = "Vote"
        releaseDateLabel.text = "Date"
        titleLabel.text = "Title"
        overviewLabel.text = "Overview"
        
        setupUI()
        setupLayout()
    }
    
    func setupUI() {
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 8
        posterView.contentMode = .scaleAspectFill
        titleLabel.numberOfLines = 0
        overviewLabel.numberOfLines = 0
        titleLabel.font = ProximaNovaFont.font(type: .bold, size: 16)
        overviewLabel.font = ProximaNovaFont.font(type: .regular, size: 14)
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
            maker.leading.equalTo(posterView.snp.trailing).offset(4)
            maker.top.equalTo(posterView)
            maker.trailing.equalToSuperview()
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
    
    func configure() {
        
    }
}
