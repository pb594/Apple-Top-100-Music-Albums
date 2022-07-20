//
//  MusicDetailVC.swift
//  AppleMusicApp
//
//  Created by dedicated developer on 19/07/22.
//

import UIKit



class MusicDetailVC: UIViewController {

    var dataModel : ItemViewModel?
    
    let albumImage: CustomImageView = {
        let itemImage = CustomImageView()
        itemImage.clipsToBounds = true
        itemImage.backgroundColor = UIColor.green
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        return itemImage
    }()
    
    let backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named:"back"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let artistNameLbl: UILabel = {
        let artistLbl = UILabel()
        artistLbl.font = UIFont.init(name:"Helvetica", size: 16.0)
        artistLbl.textColor = UIColor.init(red:142.0/255.0, green: 142.0/255.0, blue: 142.0/255.0, alpha: 1.0)
        artistLbl.clipsToBounds = true
        artistLbl.translatesAutoresizingMaskIntoConstraints = false
        return artistLbl
    }()
    
    let albumNameLbl: UILabel = {
        let albumLbl = UILabel()
        albumLbl.font = UIFont.init(name:"Helvetica-Bold", size: 19.0)
        albumLbl.textColor = UIColor.black
        albumLbl.clipsToBounds = true
        albumLbl.numberOfLines = 0
        albumLbl.translatesAutoresizingMaskIntoConstraints = false
        return albumLbl
    }()
    
    let WebsiteBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.init(red: 0.0/255.0, green: 119.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Visit The Album", for: .normal)
        btn.layer.cornerRadius = 10.0
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let copyRightLbl: UILabel = {
        let copyrightLbl = UILabel()
        copyrightLbl.font = UIFont.init(name:"Helvetica", size: 16.0)
        copyrightLbl.textColor = UIColor.gray
        copyrightLbl.clipsToBounds = true
        copyrightLbl.textAlignment = .center
        copyrightLbl.numberOfLines = 0
        copyrightLbl.text = "Copyright 2022 Apple Inc. All rights reserved."
        copyrightLbl.translatesAutoresizingMaskIntoConstraints = false
        return copyrightLbl
    }()
    
    let releaseDateLbl: UILabel = {
        let dateLbl = UILabel()
        dateLbl.font = UIFont.init(name:"Helvetica", size: 14.0)
        dateLbl.textColor = UIColor.gray
        dateLbl.clipsToBounds = true
        dateLbl.textAlignment = .center
        dateLbl.numberOfLines = 0
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        return dateLbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        self.setUpUI()
        self.populateUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Setup View using Auto Layout Contraints
    
    func setUpUI(){
        
        self.view.addSubview(albumImage)
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        self.albumImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.albumImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.albumImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -topBarHeight).isActive = true
        self.albumImage.heightAnchor.constraint(equalToConstant:390).isActive = true
        
        
        self.view.addSubview(backBtn)
        
        self.backBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.backBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant:topBarHeight-20).isActive = true
        self.backBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.backBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.backBtn.addTarget(self, action: #selector(backbtnClicked), for: .touchUpInside)
        
        self.view.addSubview(artistNameLbl)
        self.artistNameLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.artistNameLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.artistNameLbl.topAnchor.constraint(equalTo: self.albumImage.bottomAnchor , constant: 20).isActive = true
        self.artistNameLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(albumNameLbl)
        self.albumNameLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.albumNameLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.albumNameLbl.topAnchor.constraint(equalTo: self.artistNameLbl.bottomAnchor , constant: -5).isActive = true
        self.albumNameLbl.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.view.addSubview(WebsiteBtn)
        
        self.WebsiteBtn.widthAnchor.constraint(equalToConstant: 180).isActive = true
        self.WebsiteBtn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.WebsiteBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        self.WebsiteBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.WebsiteBtn.addTarget(self, action: #selector(OpenWebsiteClicked), for: .touchUpInside)
        
        self.view.addSubview(copyRightLbl)
        
        self.copyRightLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.copyRightLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.copyRightLbl.topAnchor.constraint(equalTo: self.WebsiteBtn.topAnchor , constant: -50).isActive = true
        self.copyRightLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(releaseDateLbl)
        
        self.releaseDateLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.releaseDateLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.releaseDateLbl.topAnchor.constraint(equalTo: self.copyRightLbl.topAnchor , constant: -24).isActive = true
        self.releaseDateLbl.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    // MARK: Button Actions
    
    @objc func backbtnClicked(){
       
        AppDelegate.sharedDelegate().appCoordinator.backtoPreviousPage()
        
    }
    
    @objc func OpenWebsiteClicked() {
        
        guard let url = URL(string: (self.dataModel?.dataModel!.url)!) else {
          return //be safe
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                 print("Open url : \(success)")
            })
        }
        
    }
    
    // MARK: Popuplate Data in Views
    
    func populateUI(){
        
        self.albumImage.downloadImageFrom(urlString: self.dataModel!.largeImageUrl, imageMode: .scaleAspectFill)
        self.artistNameLbl.text = self.dataModel?.dataModel?.artistName
        self.albumNameLbl.text = self.dataModel?.dataModel?.name
        self.releaseDateLbl.text = "Released On \(self.dataModel?.dataModel?.releaseDate ?? "July 2022")"
    }
}
