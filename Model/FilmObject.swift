//
//  FilmObject.swift
//  FilmApp
//
//  Created by Nikita Kirshin on 28.01.2022.
//

import Foundation
import UIKit
import RealmSwift

class FilmObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var filmPic: String = ""
    @objc dynamic var filmTitle: String = ""
    @objc dynamic var releaseYear: Int = 0
    @objc dynamic var filmRating: Double = 0
    @objc dynamic var isLikedByUser: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
