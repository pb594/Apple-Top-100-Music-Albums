//
//  ItemViewModel.swift
//  AppleMusicApp
//
//  Created by dedicated developer on 19/07/22.
//

import UIKit

class ItemViewModel: NSObject {
    
    let dataModel : ItemModel?
    var ImageUrl = ""
    var largeImageUrl = ""
    
    init(initwithItemModel itemdata: ItemModel){
       
        self.dataModel = itemdata
        let imgurlStr = self.dataModel?.artworkUrl100
        var fileArray = imgurlStr?.components(separatedBy: "/")
        fileArray?.removeLast()
        let extractedUrl = fileArray?.joined(separator: "/")
        
        largeImageUrl = extractedUrl! + "/600x600bb.jpg"
        ImageUrl = extractedUrl! + "/200x200bb.jpg"
        print(largeImageUrl)
        
    }
}
