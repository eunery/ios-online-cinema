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
    let poster = UIImageView()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupUI() {
        self.contentView.addSubview(posterView)
        posterView.clipsToBounds = false
        posterView.layer.shadowColor = UIColor.black.cgColor
        posterView.layer.shadowOpacity = 1
        posterView.layer.shadowOffset = CGSize(width: 0, height: 5)
        posterView.layer.shadowRadius = 10
        posterView.layer.cornerRadius = 10
        posterView.snp.makeConstraints { maker in
            maker.edges.equalTo(contentView)
            maker.height.equalTo(UIScreen.main.bounds.height/2 + 100)
            maker.width.equalTo(contentView)
        }
        
        posterView.addSubview(poster)
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 26
        poster.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    func configure(cell: MovieDetailsTableViewCellModel?) {
        guard let cell = cell else { return }
        let host = "image.tmdb.org"
        let scheme = "https"
        let path = "/t/p/w500"
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = path + cell.poster
        self.poster.sd_setImage(with: url.url)
    }
}
