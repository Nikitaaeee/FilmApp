//
//  FavoriteFilmCollectionViewCell.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 19.01.2022.
//

import UIKit

class FavoriteFilmCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FavFilmCell"
    
    var posterPreviewImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "image2")
//        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    var filmTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.backgroundColor = .white
        label.font = label.font.withSize(20)
        return label
    } ()
    
    var releaseYearLabel: UILabel = {
        let label = UILabel()
        label.text = "2017"
//        label.backgroundColor = .blue
        return label
    } ()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "8.3"
//        label.backgroundColor = .red
        return label
    } ()
    
    var deleteFromFav: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.bin.circle"), for: .normal)
        button.imageView?.tintColor = .red
        return button
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(posterPreviewImageView)
        contentView.addSubview(filmTitleLabel)
        contentView.addSubview(releaseYearLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(deleteFromFav)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterPreviewImageView.frame = CGRect(x: 5,
                                              y: contentView.frame.size.height-275,
                                              width: contentView.frame.size.width-10,
                                              height: 200)
        filmTitleLabel.frame = CGRect(x: 15,
                                      y: contentView.frame.size.height-75,
                                      width: contentView.frame.size.width-10,
                                      height: 30)
        releaseYearLabel.frame = CGRect(x: 15,
                                      y: contentView.frame.size.height-45,
                                      width: contentView.frame.size.width-10,
                                      height: 20)
        ratingLabel.frame = CGRect(x: 15,
                                      y: contentView.frame.size.height-25,
                                      width: contentView.frame.size.width-10,
                                      height: 20)
        deleteFromFav.frame = CGRect(x: contentView.frame.size.width/1.2,
                                     y: contentView.frame.size.height-45,
                                     width: 20,
                                     height: 20)
        
    }

    var data: Item? {
        didSet {
            guard data != nil else {
                return
            }
            posterPreviewImageView.image = UIImage(named: data?.testPic ?? "image1")
            filmTitleLabel.text = data?.testTitle
            releaseYearLabel.text = String(data?.testYear ?? 0)
            ratingLabel.text = String(data?.testRating ?? 0)
        }
    }
}


