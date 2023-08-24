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
    
    var poster: String = String()
    var posterView = UIImageView()
    var title: UILabel = UILabel()
    var genre: UILabel = UILabel()
    
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
        self.contentView.addSubview(title)
        self.contentView.addSubview(genre)
        
        setupUI()
        setupLayout()
    }
    
    func setupLayout() {
        posterView.snp.makeConstraints { maker in
            maker.leading.equalTo(contentView)
            maker.top.equalTo(contentView)
            maker.trailing.equalTo(contentView)
        }
        
        title.snp.makeConstraints { maker in
            maker.leading.equalTo(posterView.snp.leading)
            maker.top.equalTo(posterView.snp.bottom)
            maker.trailing.equalTo(contentView)
        }
        
        genre.snp.makeConstraints { maker in
            maker.leading.equalTo(title.snp.leading)
            maker.top.equalTo(title.snp.bottom)
            maker.trailing.equalTo(contentView)
            maker.bottom.equalTo(contentView)
        }
    }
    
    func setupUI() {
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 8
        posterView.contentMode = .scaleAspectFill
        title.font = ProximaNovaFont.font(type: .bold, size: 14)
        genre.font = ProximaNovaFont.font(type: .regular, size: 12)
    }
    
    func configure(cell: MovieCollectionViewCellModel) {
        self.posterView.sd_setImage(with: URL(string: cell.poster))
        self.title.text = cell.title
        self.genre.text = cell.genre
    }
    
}
