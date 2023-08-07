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
    
    var poster: UIImageView!
    var title: UILabel!
    var genre: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure() {
        poster = UIImageView()
        self.contentView.addSubview(poster)
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 8
        poster.contentMode = .scaleAspectFill
        poster.snp.makeConstraints { maker in
            maker.leading.equalTo(contentView)
            maker.top.equalTo(contentView)
            maker.trailing.equalTo(contentView)
        }
        
        title  = UILabel()
        self.contentView.addSubview(title)
        title.font = ProximaNovaFont.font(type: .bold, size: 20)
        title.snp.makeConstraints { maker in
            maker.leading.equalTo(poster.snp.leading)
            maker.top.equalTo(poster.snp.bottom)
            maker.trailing.equalTo(contentView)
        }
        
        genre = UILabel()
        self.contentView.addSubview(genre)
        genre.font = ProximaNovaFont.font(type: .regular, size: 17)
        genre.snp.makeConstraints { maker in
            maker.leading.equalTo(title.snp.leading)
            maker.top.equalTo(title.snp.bottom)
            maker.trailing.equalTo(contentView)
            maker.bottom.equalTo(contentView)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
