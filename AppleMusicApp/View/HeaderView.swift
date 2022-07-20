//
//  HeaderView.swift
//  AppleMusicApp
//
//  Created by dedicated developer on 20/07/22.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let pageHeadingLbl: UILabel = {
        let headingLbl = UILabel()
        headingLbl.font = UIFont.init(name:"Helvetica-Bold", size: 24.0)
        headingLbl.textColor = UIColor.black
        headingLbl.clipsToBounds = true
        headingLbl.numberOfLines = 0
        headingLbl.text = "Top 100 Albums"
        headingLbl.translatesAutoresizingMaskIntoConstraints = false
        return headingLbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        
        addSubview(pageHeadingLbl)
        // set constraints
        self.pageHeadingLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.pageHeadingLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.pageHeadingLbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.pageHeadingLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
        
}
