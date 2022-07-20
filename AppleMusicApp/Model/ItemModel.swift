//
//  ItemModel.swift
//  AppleMusicApp
//
//  Created by dedicated developer on 19/07/22.
//

import Foundation
import RealmSwift

class ItemModel: Object{
    
    @objc dynamic var artistName           = ""
    @objc dynamic var name                 = ""
    @objc dynamic var url                  = ""
    @objc dynamic var releaseDate          = ""
    @objc dynamic var artworkUrl100        = ""
    
}
