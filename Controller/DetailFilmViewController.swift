//
//  DetailFilmViewController.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 11.01.2022.
//

import UIKit

class DetailFilmViewController: UIViewController {

    static let identifier = "DetailFilmViewController"
    
    let model = Model()
    let transition: RoundingTransition = RoundingTransition()
    private var galleryCollectionView: UICollectionView?
    
    //Получаемый id из FavoriteFilmsCollectionView
    var receivedIndex: Int = Int()
    
    //Проверка откуда идет переход (из Избранных фильмов или из MainVC)
    var cameFromFav:Bool = false
    
    let staticRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "Рейтинг:"
//        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    let staticDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание:"
//        label.backgroundColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    } ()
    
    let staticCollectionViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Кадры, съемки"
        return label
    } ()
    
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "image2")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var releaseYearLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .blue
        label.font = label.font.withSize(15)
        return label
    } ()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
        label.font = label.font.withSize(30)
        return label
    } ()
    
    var addToFavBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(addToFavBtnPressed), for: .touchUpInside)
//        button.imageView?.tintColor = .red
        return button
    } ()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "TEST"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .green
        return label
    } ()
    
    @objc func addToFavBtnPressed(_ sender: UIButton) {
        model.updateLike(at: receivedIndex)
        if addToFavBtn.alpha == 1 {
            addToFavBtn.alpha =  0.45
            addToFavBtn.tintColor = .gray
        } else {
            addToFavBtn.alpha = 1
            addToFavBtn.tintColor = .black
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print(receivedIndex)
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1
        
        view.addSubview(posterImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(ratingLabel)
        view.addSubview(staticRatingLabel)
        view.addSubview(releaseYearLabel)
        view.addSubview(staticDescriptionLabel)
        view.addSubview(addToFavBtn)
        
        // Применение constraints
        adjustConstraintsImage()
        adjustConstraintsDescription()
        adjustConstraintsRating()
        adjustConstraintsStaticRating()
        adjustConstraintsYear()
        adjustConstraintsStaticDescription()
        adjustConstraintsAddToFavBtn()
        
        
//MARK: - Collection View
        galleryCollectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        guard let galleryCollectionView = galleryCollectionView else {return}
        galleryCollectionView.register(FilmPicsCollectionViewCell.self, forCellWithReuseIdentifier: FilmPicsCollectionViewCell.identifier)
        galleryCollectionView.dataSource = self
        galleryCollectionView.delegate = self
        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(galleryCollectionView)
        
        let collectionViewConstraints = [
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            galleryCollectionView.heightAnchor.constraint(equalToConstant: 80),
            galleryCollectionView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5)
        ]
        
        NSLayoutConstraint.activate(collectionViewConstraints)
        
        
//MARK: - Наполнение лейблов и изображений
        if cameFromFav {
            
            model.showLikedFilms()
            
            //Вычисление нужного элемента в likedFilmsArray на основании id
            let element = model.likedFilmObjects?.first(where: {$0.id == receivedIndex})
            
            navigationItem.title = element?.filmTitle ?? "w"
            posterImageView.image = UIImage(named: element?.filmPic ?? "image1")
            ratingLabel.text = String(element?.filmRating ?? 0.0)
            releaseYearLabel.text = String(element?.releaseYear ?? 0000)
            
            // Проверка для закрашивания сердечка
            if element?.isLikedByUser == true {
                addToFavBtn.alpha = 1
                addToFavBtn.tintColor = .black
            } else {
                addToFavBtn.alpha = 0.45
                addToFavBtn.tintColor = .gray
            }
        } else {
            let element = model.filmObjects?[receivedIndex]
            navigationItem.title = element?.filmTitle ?? "TEST"
            posterImageView.image = UIImage(named: element?.filmPic ?? "image1")
            ratingLabel.text = String(element?.filmRating ?? 0.0)
            releaseYearLabel.text = String(element?.releaseYear ?? 0000)

            if model.filmObjects?[receivedIndex].isLikedByUser == true {
                addToFavBtn.alpha = 1
                addToFavBtn.tintColor = .black
            } else {
                addToFavBtn.alpha = 0.45
                addToFavBtn.tintColor = .gray
            }
        }
        
    }
    
//MARK: - Constraints
    
    func adjustConstraintsImage() {
        
        let constraints: [NSLayoutConstraint] = [
            posterImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                     constant: 10),
            posterImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: -view.frame.width/2.5),
            posterImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -view.frame.height/2.5),
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func adjustConstraintsStaticRating() {
        
        let constraints: [NSLayoutConstraint] = [
            staticRatingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                       constant: view.frame.width/1.6),
            staticRatingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -10),
            staticRatingLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                      constant: -view.frame.height/1.3),
            staticRatingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func adjustConstraintsRating() {
        
        let constraints: [NSLayoutConstraint] = [
            ratingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: view.frame.width/1.6),
            ratingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -10),
            ratingLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                constant: -view.frame.height/1.6),
            ratingLabel.topAnchor.constraint(equalTo: staticRatingLabel.bottomAnchor,
                                             constant: 5)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func adjustConstraintsYear() {
        
        let constraints: [NSLayoutConstraint] = [
            releaseYearLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: view.frame.width/1.6),
            releaseYearLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -10),
            releaseYearLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                     constant: -view.frame.height/1.8),
            releaseYearLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor,
                                                  constant: 5)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func adjustConstraintsAddToFavBtn() {
        
        let constraints: [NSLayoutConstraint] = [
            addToFavBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: view.frame.width/1.6),
            addToFavBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -10),
            addToFavBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                constant: -view.frame.height/2.5),
            addToFavBtn.topAnchor.constraint(equalTo: releaseYearLabel.bottomAnchor,
                                             constant: 5)]

        NSLayoutConstraint.activate(constraints)
    }
    
    func adjustConstraintsStaticDescription() {

        let constraints: [NSLayoutConstraint] = [
            staticDescriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                            constant: 10),
            staticDescriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                             constant: -10),
            staticDescriptionLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            staticDescriptionLabel.topAnchor.constraint(equalTo: galleryCollectionView?.bottomAnchor ?? view.safeAreaLayoutGuide.bottomAnchor,
                                                        constant: -view.frame.height/3.5)]

        NSLayoutConstraint.activate(constraints)
    }
//
    func adjustConstraintsDescription() {

        let constraints: [NSLayoutConstraint] = [
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: staticDescriptionLabel.bottomAnchor)]

        NSLayoutConstraint.activate(constraints)
    }
  
}

//MARK: - EXTENSIONS

extension DetailFilmViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmPicsCollectionViewCell.identifier,
                                                            for: indexPath) as? FilmPicsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.posterPreviewImageView.image = UIImage(named: model.filmObjects?[indexPath.item].filmPic ?? "image1")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80,
                      height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = FullPicsViewController()
        destVC.receivedIndex = model.filmObjects?[indexPath.row].id ?? 0
//        navigationController?.pushViewController(destVC, animated: true)
        self.present(destVC, animated: true, completion: nil)
    }


}
    
    
//    MARK: -- Animation
//extension DetailFilmViewController: UIViewControllerTransitioningDelegate {
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        transition.TransitionProfile = .show
//        transition.start = posterImageView.center
//        transition.roundColor = UIColor.white
//
//        return transition
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        transition.TransitionProfile = .cancel
//        transition.start = posterImageView.center
//        transition.roundColor = UIColor.white
//
//        return transition
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destVC = segue.destination as? PosterFullViewController else {
//            return
//
//        }
//        destVC.detailIndexPath = receivedIndex
//        destVC.transitioningDelegate = self
//        destVC.modalPresentationStyle = .custom
//
//    }
//}

/*
 @IBOutlet weak var posterImageView: UIImageView!
 @IBOutlet weak var filmTitleLabel: UILabel!
 @IBOutlet weak var releaseYearLabel: UILabel!
 @IBOutlet weak var ratingLabel: UILabel!
 @IBOutlet weak var galleryCollection: UICollectionView!
 @IBOutlet weak var descriptionTextView: UITextView!
 */

