//
//  MainViewController.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 11.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    private var collectionView: UICollectionView?
    
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "All Films"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
//        layout.itemSize = CGSize(width: ((view.frame.size.width)/2-1),
//                                 height: ((view.frame.size.height)/3-1))
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(FilmCollectionViewCell.self,
                                forCellWithReuseIdentifier: FilmCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
//        print(collectionView.bounds.height)
        
        
    }
}
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifier,
                                                            for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.posterPreviewImageView.image = UIImage(named: model.testArray[indexPath.row].testPic ?? "image1")
        cell.filmTitleLabel.text = String(model.testArray[indexPath.row].testTitle ?? "Test Title")
        cell.releaseYearLabel.text = String(model.testArray[indexPath.row].testYear ?? 1993)
        cell.ratingLabel.text = String(model.testArray[indexPath.row].testRating ?? 10.0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
//        return CGSize(width: ((view.frame.size.width)/2-1),
//                      height: ((view.frame.size.height)/3))
        
        return CGSize(width: (collectionView.bounds.width/2)-4,
                      height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destVC = DetailFilmViewController()
        destVC.receivedIndex = model.testArray[indexPath.row].id ?? 0
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
}
