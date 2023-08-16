//
//  MovieCollectionViewCell.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 05.08.2023.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "MovieCell"
    
    var id: Int?
    var poster: String = String()
    var posterView = UIImageView()
    var title: UILabel = UILabel()
    var genre: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        self.contentView.addSubview(posterView)
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 8
        posterView.contentMode = .scaleAspectFill
        posterView.snp.makeConstraints { maker in
            maker.leading.equalTo(contentView)
            maker.top.equalTo(contentView)
            maker.trailing.equalTo(contentView)
        }
        
        self.contentView.addSubview(title)
        title.font = ProximaNovaFont.font(type: .bold, size: 14)
        title.snp.makeConstraints { maker in
            maker.leading.equalTo(posterView.snp.leading)
            maker.top.equalTo(posterView.snp.bottom)
            maker.trailing.equalTo(contentView)
        }
        
        self.contentView.addSubview(genre)
        genre.font = ProximaNovaFont.font(type: .regular, size: 12)
        genre.snp.makeConstraints { maker in
            maker.leading.equalTo(title.snp.leading)
            maker.top.equalTo(title.snp.bottom)
            maker.trailing.equalTo(contentView)
            maker.bottom.equalTo(contentView)
        }
    }
    
    func configure(cell: MovieCollectionViewCellModel) {
        let host = "image.tmdb.org"
        let scheme = "https"
        let path = "/t/p/w500"
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = path + cell.poster
        self.posterView.sd_setImage(with: url.url)
        self.id = cell.id
        self.title.text = cell.title
        self.genre.text = cell.genre
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
