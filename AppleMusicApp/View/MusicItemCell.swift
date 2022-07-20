//
//  MusicItemCell.swift
//  AppleMusicApp
//
//  Created by dedicated developer on 19/07/22.
//

import UIKit

class MusicItemCell: UICollectionViewCell {
    
    let albumImage: CustomImageView = {
        let itemImage = CustomImageView()
        itemImage.layer.cornerRadius = 18
        itemImage.clipsToBounds = true
        itemImage.backgroundColor = UIColor.green
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        return itemImage
    }()
    
    let layerImage: UIImageView = {
        let itemImage = UIImageView()
        itemImage.layer.cornerRadius = 18
        itemImage.clipsToBounds = true
        itemImage.backgroundColor = UIColor.black
        itemImage.alpha = 0.35
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        return itemImage
    }()
    
    let artistNameLbl: UILabel = {
        let artistLbl = UILabel()
        artistLbl.font = UIFont.init(name:"Helvetica", size: 14.0)
        artistLbl.textColor = UIColor.init(red:181.0/255.0, green: 181.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        artistLbl.clipsToBounds = true
        artistLbl.translatesAutoresizingMaskIntoConstraints = false
        return artistLbl
    }()
    
    let albumNameLbl: UILabel = {
        let albumLbl = UILabel()
        albumLbl.font = UIFont.init(name:"Helvetica-Bold", size: 15.0)
        albumLbl.textColor = UIColor.white
        albumLbl.clipsToBounds = true
        albumLbl.numberOfLines = 0
        albumLbl.translatesAutoresizingMaskIntoConstraints = false
        return albumLbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup View using Auto Layout Contraints
    
    func addViews(){
     
        addSubview(albumImage)
        
        // set constraints
        self.albumImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.albumImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.albumImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.albumImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(layerImage)
        
        // set constraints
        self.layerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.layerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.layerImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.layerImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(artistNameLbl)
        self.artistNameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.artistNameLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.artistNameLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -10).isActive = true
        self.artistNameLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(albumNameLbl)
        self.albumNameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.albumNameLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.albumNameLbl.bottomAnchor.constraint(equalTo: self.artistNameLbl.topAnchor , constant: 2).isActive = true
        
        self.albumNameLbl.heightAnchor.constraint(equalToConstant: 24).isActive = true

        
    }
    
}
