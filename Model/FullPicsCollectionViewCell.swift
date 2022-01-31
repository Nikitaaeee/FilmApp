//
//  FullPicsCollectionViewCell.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 28.01.2022.
//

//import UIKit
//
//class FullPicsCollectionViewCell: UICollectionViewCell {
//    
//    static let identifier = "FullPicCell"
//    
//    var posterPreviewImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "image2")
////        imageView.backgroundColor = .yellow
//        imageView.contentMode = .scaleAspectFill
////        imageView.layer.cornerRadius = 10
////        imageView.clipsToBounds = true
//        imageView.backgroundColor = .red
//        return imageView
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(posterPreviewImageView)
//        contentView.backgroundColor = .white
//
//       
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        posterPreviewImageView.frame = CGRect(x: 0,
//                                              y: 0,
//                                              width: 200 ,
//                                              height: 200)
//    }
//}
