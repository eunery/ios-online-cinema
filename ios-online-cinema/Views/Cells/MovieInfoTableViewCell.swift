//
//  MovieInfoTableViewCell.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 16.08.2023.
//

import Foundation
import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "MovieInfoCell"
    var isButtonOn: Bool = false
    
    let stackView = UIStackView()
    var genre = UILabel()
    var vote = UILabel()
    var date = UILabel()
    var button = UIButton()
    
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
        self.contentView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(10)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().inset(10)
        }
        
        stackView.addArrangedSubview(genre)
        genre.font = ProximaNovaFont.font(type: .bold, size: 14)
        genre.textAlignment = .center
        genre.numberOfLines = 0

        stackView.addArrangedSubview(vote)
        vote.font = ProximaNovaFont.font(type: .bold, size: 16)
        vote.textAlignment = .center

        stackView.addArrangedSubview(button)
        button.tintColor = .red
        button.setImage(UIImage(systemName: isButtonOn ? "heart.fill" : "heart"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        stackView.addArrangedSubview(date)
        date.font = ProximaNovaFont.font(type: .bold, size: 14)
        date.textAlignment = .center
    }
    
    func configure(cell: MovieDetailsTableViewCellModel?) {
        guard let cell = cell else { return }
        self.genre.text = cell.genre
        self.vote.text = cell.vote
        self.date.text = cell.releaseDate
    }
    
    @objc func buttonPressed() {
        isButtonOn.toggle()
        button.setImage(UIImage(systemName: isButtonOn ? "heart.fill" : "heart"), for: .normal)
    }
}
