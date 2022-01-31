//
//  MainViewController.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 11.01.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UISearchBarDelegate {

    private var collectionView: UICollectionView?
    
    var searchController = UISearchController()
    
    let model = Model()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.arrayHelper = model.filmObjects
        
        //MARK: - Блок для принта с адресом файла Realm
//        let realm = try? Realm()
//        let filmObject = FilmObject()
//        do{
//            try realm?.write({
//                realm?.add(filmObject)
//            })
//        }catch{
//            print("\(error.localizedDescription)")
//        }
//        print(realm?.configuration.fileURL)
//        model.ratingSort()
        


        //MARK: - Search Bar
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Find Your Film"
        
        //MARK: -  Navigation Controller
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "All Films"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(goToFav))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(sortRating))
                
        //MARK: -  Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        //MARK: -  Collection View
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
        collectionView.reloadData()
        
        
    }
    //MARK: - Методы
    
    @objc func goToFav() {
        let destVC = FavoriteFilmViewController()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    @objc func sortRating() {
        let arrowUp = UIImage(systemName: "arrow.up")
        let arrowDown = UIImage(systemName: "arrow.down")
        model.sortAscending = !model.sortAscending
        navigationItem.rightBarButtonItem?.image = model.sortAscending ? arrowUp : arrowDown
        model.ratingSort()
        collectionView!.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.arrayHelper = model.filmObjects
        model.search(searchTextValue: searchText)
        
        if searchBar.text?.count == 0 {
            model.arrayHelper = model.filmObjects
            model.ratingSort()
        }
        collectionView?.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.arrayHelper = model.filmObjects
        
        if searchBar.text?.count == 0 {
            model.arrayHelper = model.filmObjects
            model.ratingSort()
        }
        
        model.ratingSort()
        collectionView?.reloadData()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return model.arrayHelper?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifier,
                                                            for: indexPath) as? FilmCollectionViewCell,
              let item = model.arrayHelper?[indexPath.row]  else {
                  return UICollectionViewCell()
              }
        cell.data = item
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
        destVC.receivedIndex = model.arrayHelper?[indexPath.row].id ?? 0
        destVC.cameFromFav = false
        navigationController?.pushViewController(destVC, animated: true)
    }
}

