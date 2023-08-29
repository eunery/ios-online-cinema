//
//  MovieInfoTableViewCell.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 16.08.2023.
//

import Foundation
import UIKit

protocol MovieInfoTableViewCellCallback {
    func didTapHeart()
}

class MovieInfoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "MovieInfoCell"
    var isButtonOn: Bool = false
    var cellDelegate: MovieInfoTableViewCellCallback?
    
    let infoStackView = UIStackView()
    var genreLabel = UILabel()
    var voteLabel = UILabel()
    var dateLabel = UILabel()
    var addToFavouritesButton = UIButton()
    
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
        self.contentView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(genreLabel)
        infoStackView.addArrangedSubview(voteLabel)
        infoStackView.addArrangedSubview(addToFavouritesButton)
        infoStackView.addArrangedSubview(dateLabel)
        
        setupUI()
        setupLayout()
    }
    
    func setupUI() {
        infoStackView.axis = .horizontal
        infoStackView.alignment = UIStackView.Alignment.center
        infoStackView.distribution = UIStackView.Distribution.fillEqually
        
        genreLabel.font = ProximaNovaFont.font(type: .bold, size: 14)
        genreLabel.textAlignment = .center
        genreLabel.numberOfLines = 0
        
        voteLabel.font = ProximaNovaFont.font(type: .bold, size: 16)
        voteLabel.textAlignment = .center
        
        addToFavouritesButton.tintColor = .red
        addToFavouritesButton.setImage(UIImage(systemName: isButtonOn ? "heart.fill" : "heart"), for: .normal)
        addToFavouritesButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        dateLabel.font = ProximaNovaFont.font(type: .bold, size: 14)
        dateLabel.textAlignment = .center
    }
    
    func setupLayout() {
        infoStackView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(10)
            maker.leading.equalToSuperview().inset(5)
            maker.trailing.equalToSuperview().inset(5)
            maker.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(cellModel: MoviesDetailsInfoCellData) {
        self.genreLabel.text = cellModel.genres
        self.voteLabel.text = cellModel.vote
        self.dateLabel.text = cellModel.date
    }
    
    @objc func buttonPressed() {
        self.cellDelegate?.didTapHeart()
        isButtonOn.toggle()
        addToFavouritesButton.setImage(UIImage(systemName: isButtonOn ? "heart.fill" : "heart"), for: .normal)
    }
}
