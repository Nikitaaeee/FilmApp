//
//  MainViewController.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 11.01.2022.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {

    private var collectionView: UICollectionView?
    
    var searchController = UISearchController()
    
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(model.testArray)
        print(model.likedFilmsArray)

        // Search Bar
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Find Your Film"
        
        // Navigation Controller
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "All Films"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(goToFav))
                
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        // Collection View
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
    
    @objc func goToFav() {
        let destVC = FavoriteFilmViewController()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
        // Методы Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.search(searchTextValue: searchText)
        collectionView!.reloadData()
        print("aaa")

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.newTestArray = model.testArray
        collectionView?.reloadData()
        print("ooo")
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return model.testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifier,
                                                            for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.model.testArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
//        return CGSize(width: ((view.frame.size.width)/2-1),
//                      height: ((view.frame.size.height)/3))
        
        return CGSize(width: (collectionView.bounds.width/2)-4,
                      height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let destVC = DetailFilmViewController()
        destVC.receivedIndex = model.testArray[indexPath.row].id ?? 0
        destVC.cameFromFav = false
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
}

