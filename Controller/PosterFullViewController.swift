//
//  PosterFullViewController.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 11.01.2022.
//

import UIKit

class PosterFullViewController: UIViewController {

    let fullPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image2")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var detailIndexPath: Int = Int()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fullPosterImageView)
        adjustConstraintsPoster()
        fullPosterImageView.image = UIImage(named: Model().testArray[detailIndexPath].testPic ?? "image1")
 
    }
    

    func adjustConstraintsPoster() {
        
        let constraints: [NSLayoutConstraint] = [
            fullPosterImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            fullPosterImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            fullPosterImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            fullPosterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
