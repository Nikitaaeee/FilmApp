//
//  FullPicsViewController.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 11.01.2022.
//

import UIKit

class FullPicsViewController: UIViewController {
    
    let model = Model()
    
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "image2")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var closeBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        return button
    } ()
            
    var receivedIndex: Int = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let element = model.testArray[receivedIndex]
        posterImageView.image = UIImage(named: element.testPic ?? "image1")
        
        view.addSubview(posterImageView)
        view.addSubview(closeBtn)
        
        adjustConstraints()

    }
    
    //MARK: - Close VC button action
    
    @objc func closeVC() {
        self.dismiss(animated: true, completion: nil)
    }
    

    //MARK: - Constraints
    
    func adjustConstraints() {
        let imageViewConstraints = [
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        
        let btnConstraints = [
            closeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            closeBtn.heightAnchor.constraint(equalToConstant: 50)
            ]
        NSLayoutConstraint.activate(btnConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
}


    

