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

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorite Films"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.triangle.2.circlepath.circle.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(updateCV))
        
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
    
    @objc func updateCV() {
        collectionView?.reloadData()
    }
    
}
extension FavoriteFilmViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.likedFilmObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteFilmCollectionViewCell.identifier,
                                                            for: indexPath) as? FavoriteFilmCollectionViewCell,
              let likedItem = model.likedFilmObjects?[indexPath.item]  else {
                  return UICollectionViewCell()
              }
        
        cell.data = likedItem
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
        destVC.receivedIndex = model.likedFilmObjects?[indexPath.row].id ?? 0
        destVC.cameFromFav = true
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
}
