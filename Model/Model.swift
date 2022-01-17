//
//  Model.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 11.01.2022.
//

import Foundation
import UIKit

class Item {
    var id: Int?
    var testPic: String?
    var testTitle: String?
    var testYear: Int?
    var testRating: Double?
    var isLiked: Bool?
     
    init(id: Int?, testPic: String?, testTitle: String?, testYear: Int?, testRating: Double?, isLiked: Bool? ) {
        self.id = id
        self.testPic = testPic
        self.testTitle = testTitle
        self.testYear = testYear
        self.testRating = testRating
        self.isLiked = isLiked
    }
}


class Model {
    
    
    
    var newTestArray = [Item]()
    var likedFilmsArray = [Item]()
    
    // Тестовый array до добавления в проект сетевого взаимодействия
    public var testArray: [Item] = [
        Item(id: 0, testPic: "image1", testTitle: "Фильм 1", testYear: 2001, testRating: 4.7, isLiked: true),
        Item(id: 1, testPic: "image2", testTitle: "Фильм 2", testYear: 2003, testRating: 4.1, isLiked: false),
        Item(id: 2, testPic: "image3", testTitle: "Фильм 3", testYear: 2013, testRating: 4.3, isLiked: false),
        Item(id: 3, testPic: "image4", testTitle: "Фильм 4", testYear: 2015, testRating: 4.2, isLiked: false),
        Item(id: 4, testPic: "image5", testTitle: "Фильм 5", testYear: 2016, testRating: 9.0, isLiked: false),
        Item(id: 5, testPic: "image6", testTitle: "Фильм 6", testYear: 2017, testRating: 4.6, isLiked: false),
        Item(id: 6, testPic: "image7", testTitle: "Фильм 7", testYear: 2021, testRating: 6.9, isLiked: true),
        Item(id: 7, testPic: "image8", testTitle: "Фильм 8", testYear: 2004, testRating: 5.3, isLiked: false),
        Item(id: 8, testPic: "image9", testTitle: "Фильм 9", testYear: 2005, testRating: 1.4, isLiked: false),
        Item(id: 9, testPic: "image10", testTitle: "Фильм 10", testYear: 2008, testRating: 5.8, isLiked: false),
        Item(id: 10, testPic: "image11", testTitle: "Фильм 11", testYear: 2000, testRating: 4.9, isLiked: false),
        Item(id: 11, testPic: "image12", testTitle: "Фильм 12", testYear: 2009, testRating: 4.3, isLiked: false),
        Item(id: 12, testPic: "image13", testTitle: "Фильм 13", testYear: 2007, testRating: 1.9, isLiked: true),
        Item(id: 13, testPic: "image14", testTitle: "Фильм 14", testYear: 2001, testRating: 8.5, isLiked: false),
        Item(id: 14, testPic: "image15", testTitle: "Фильм 15", testYear: 2004, testRating: 7.7, isLiked: true)
    ]
}
