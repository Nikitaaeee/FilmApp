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
    
    func likeButtonAction(_ sender: UIButton) {
        
    }
    
//    private var galleryCollectionView = UICollectionView()



    override func viewDidLoad() {
        super.viewDidLoad()

        print(receivedIndex)
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
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
        
        
//        // Добавление Horizontal Collection View
//        galleryCollectionView = UICollectionView(frame: .zero,
//                                          collectionViewLayout: layout)
//        galleryCollectionView.register(FilmPicsCollectionViewCell.self,
//                                forCellWithReuseIdentifier: FilmPicsCollectionViewCell.identifier)
//        galleryCollectionView.dataSource = self
//        galleryCollectionView.delegate = self
//        view.addSubview(galleryCollectionView)
        
        // Наполнение лейблов и изображений
        if cameFromFav {
            
            model.showLikedFilms()
            
            //Вычисление нужного элемента в likedFilmsArray на основании id
            let element = model.likedFilmsArray.first(where: {$0.id == receivedIndex})
            
            navigationItem.title = element?.testTitle ?? "w"
            posterImageView.image = UIImage(named: element?.testPic ?? "image1")
            ratingLabel.text = String(element?.testRating ?? 0.0)
            releaseYearLabel.text = String(element?.testYear ?? 0000)
            
            // Проверка для закрашивания сердечка
            if element?.isLiked == true {
                addToFavBtn.alpha = 1
                addToFavBtn.tintColor = .black
            } else {
                addToFavBtn.alpha = 0.45
                addToFavBtn.tintColor = .gray
            }
        } else {
//            navigationItem.title = Model().testArray[receivedIndex].testTitle ?? "TEST"
//            posterImageView.image = UIImage(named: Model().testArray[receivedIndex].testPic ?? "image1")
//            ratingLabel.text = String(Model().testArray[receivedIndex].testRating ?? 0.0)
//            releaseYearLabel.text = String(Model().testArray[receivedIndex].testYear ?? 0000)

            let element = model.testArray[receivedIndex]
            navigationItem.title = element.testTitle ?? "TEST"
            posterImageView.image = UIImage(named: element.testPic ?? "image1")
            ratingLabel.text = String(element.testRating ?? 0.0)
            releaseYearLabel.text = String(element.testYear ?? 0000)

            if model.testArray[receivedIndex].isLiked == true {
                addToFavBtn.alpha = 1
                addToFavBtn.tintColor = .black
            } else {
                addToFavBtn.alpha = 0.45
                addToFavBtn.tintColor = .gray
            }
        }
        
    }
    
    
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
            staticDescriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                           constant: -view.frame.height/2.7),
            staticDescriptionLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor)]

        NSLayoutConstraint.activate(constraints)
    }
    
    func adjustConstraintsDescription() {

        let constraints: [NSLayoutConstraint] = [
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -view.frame.height/2.5)]

        NSLayoutConstraint.activate(constraints)
    }
    
//    func adjustConstraintsGalleryCollectionView() {
//
//        let constraints: [NSLayoutConstraint] = [
//            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
//                                                      constant: 10),
//            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
//                                                       constant: -10),
//            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            descriptionLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor)]
//
//        NSLayoutConstraint.activate(constraints)
//    }
    
    
}

//extension DetailFilmViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmPicsCollectionViewCell.identifier,
//                                                            for: indexPath) as? FilmPicsCollectionViewCell else {
//            return UICollectionViewCell()
//        }
////        cell.data = self.model.likedFilmsArray[indexPath.item]
//        return cell
//    }
//
//
//}
    
    
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

