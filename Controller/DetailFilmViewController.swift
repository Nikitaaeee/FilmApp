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
    
    var receivedIndex: Int = Int()

    
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "image2")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var filmTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.textColor = .black
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    } ()
    
    var releaseYearLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
        return label
    } ()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
    } ()
//    var galleryCollection: UICollectionView = {
//        let collectionView = UICollectionView()
//
//
//        return collectionView
//    } ()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "TEST"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        return label
    } ()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(posterImageView)
        view.addSubview(filmTitleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(ratingLabel)
        
        adjustConstraintsImage()
        adjustConstraintsTitle()
        adjustConstraintsDescription()
        adjustConstraintsRating()
        
        posterImageView.image = UIImage(named: Model().testArray[receivedIndex].testPic ?? "image1")
        filmTitleLabel.text = Model().testArray[receivedIndex].testTitle ?? "TEST"
        navigationItem.title = Model().testArray[receivedIndex].testTitle ?? "TEST"
        
        
    }

    
//    func adjustConstraintsTitle() {
//
//        let constraints: [NSLayoutConstraint] = [
//            filmTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.width/2),
//            filmTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            filmTitleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height/1.5),
//            filmTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)]
//
//        NSLayoutConstraint.activate(constraints)
//
//    }
    
    func adjustConstraintsImage() {
        
        let constraints: [NSLayoutConstraint] = [
            posterImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            posterImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -view.frame.width/2),
            posterImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height/2),
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    func adjustConstraintsRating() {
        
        let constraints: [NSLayoutConstraint] = [
            ratingLabel.leadingAnchor.constraint(equalTo: filmTitleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: filmTitleLabel.trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: filmTitleLabel.bottomAnchor, constant: 40),
            ratingLabel.topAnchor.constraint(equalTo: filmTitleLabel.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)

        
    }

    func adjustConstraintsDescription() {

        let constraints: [NSLayoutConstraint] = [
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 50)]

        NSLayoutConstraint.activate(constraints)

    }
}

/*
 @IBOutlet weak var posterImageView: UIImageView!
 @IBOutlet weak var filmTitleLabel: UILabel!
 @IBOutlet weak var releaseYearLabel: UILabel!
 @IBOutlet weak var ratingLabel: UILabel!
 @IBOutlet weak var galleryCollection: UICollectionView!
 @IBOutlet weak var descriptionTextView: UITextView!
 */

