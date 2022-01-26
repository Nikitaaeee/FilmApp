//
//  FavoriteFilmViewController.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 11.01.2022.
//

import UIKit

class FavoriteFilmViewController: UIViewController {

    private var collectionView: UICollectionView?
    
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.showLikedFilms()
        print(model.likedFilmsArray)

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorite Films"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(FavoriteFilmCollectionViewCell.self,
                                forCellWithReuseIdentifier: FavoriteFilmCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
//        print(collectionView.bounds.height)
        
        
    }
}
extension FavoriteFilmViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.likedFilmsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteFilmCollectionViewCell.identifier,
                                                            for: indexPath) as? FavoriteFilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.model.likedFilmsArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.width/2)-4,
                      height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let destVC = DetailFilmViewController()
        destVC.receivedIndex = model.likedFilmsArray[indexPath.row].id ?? 0
        destVC.cameFromFav = true
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
}
