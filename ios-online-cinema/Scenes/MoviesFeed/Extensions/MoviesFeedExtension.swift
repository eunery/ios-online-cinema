//
//  MoviesFeedExtension.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 20.10.2023.
//

import Foundation
import UIKit

extension MoviesFeedViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(cellModel: self.viewModel.dataSource[indexPath.row])
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellsPerRow: CGFloat = 2
            let padding: CGFloat = 10
            let cellWidth = (collectionView.bounds.width / cellsPerRow) - padding
            let cellHeight: CGFloat = 286
            return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
            if self.viewModel.validatePage(indexPath: indexPath) {
                self.handleLoadingIndication(isLoading: true)
                self.viewModel.fetch(page: self.viewModel.currentPage) { result in
                    switch result {
                    case .failure(let error):
                        self.showError(error: error)
                        self.handleLoadingIndication(isLoading: false)
                    case .success:
                        collectionView.reloadData()
                        self.handleLoadingIndication(isLoading: false)
                    }
                }
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell {
            guard let id = cell.id else { return }
            self.coordinator?.showMoviesDetails(movieId: id)
        }
    }
}
