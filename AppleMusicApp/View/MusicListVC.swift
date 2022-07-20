//
//  MusicListVC.swift
//  AppleMusicApp
//
//  Created by dedicated developer on 18/07/22.
//

import UIKit
import RealmSwift


class MusicListVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    // MARK: Allocating Memory to Controls & Varibles used in Class
    
    lazy var loader: UIActivityIndicatorView = {
        let xAxis = self.view.center.x
        let yAxis = self.view.center.y
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.center = view.center
        indicator.startAnimating()
        return indicator
    }()
    
    let slice = UIScreen.main.bounds.height
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
        let f = UICollectionViewFlowLayout()
        f.scrollDirection = UICollectionView.ScrollDirection.vertical
        f.itemSize = CGSize(width: (self.view.frame.width / 2) - 20, height: 170)
        let space = 10.0 as CGFloat
        // Set left and right margins
        f.minimumInteritemSpacing = space
        // Set top and bottom margins
        f.minimumLineSpacing = space
        
        
        return f
    }()
    
    lazy var collection: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.setCollectionViewLayout(self.flowLayout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.clear
        cv.register(MusicItemCell.self, forCellWithReuseIdentifier: "cell")
        cv.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        return cv
    }()
    
    
    let noRecordsMsgLbl: UILabel = {
        let messageLbl = UILabel()
        messageLbl.font = UIFont.init(name:"Helvetica", size: 14.0)
        messageLbl.textColor = UIColor.init(red:181.0/255.0, green: 181.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        messageLbl.clipsToBounds = true
        messageLbl.numberOfLines = 2
        messageLbl.textAlignment = .center
        messageLbl.text = "No Record Available.\nPlease check you Internet connection."
        messageLbl.translatesAutoresizingMaskIntoConstraints = false
        return messageLbl
    }()
    
    let RetryBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.init(red: 0.0/255.0, green: 119.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Retry", for: .normal)
        btn.layer.cornerRadius = 10.0
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let realm = try! Realm()
    lazy var itemList: Results<ItemModel> = { self.realm.objects(ItemModel.self) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top 100 Albums"
        self.setUpUI()
        
        // Below lines of code check if the Data is cached or not?
        if(itemList.count == 0){
            self.callMusicListApi()
        }else {
            
            self.collection.reloadData()
            self.callMusicListApi()
        }
        
    }
    
    // MARK: Create UI Component
    
    func setUpUI(){
    
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collection)
        self.collection.frame = self.view.bounds
        
        var insets = self.collection.contentInset
        insets.left = 10
        insets.right = 10
        insets.top = 20
        self.collection.contentInset =  insets
        
    }
    
    // MARK: Api Calling Method
    
    func callMusicListApi(){
        
        let networkStatus = NetworkManager.isConnectedToNetwork()
        if(networkStatus == true){
            
            self.view.addSubview(self.loader)
            
            DataManager.fetch(requestURL: URL.init(string: Config().API_URL)!, requestType: "GET", parameter: nil, success: { (result) in
                
                DispatchQueue.main.async {
                    self.loader.removeFromSuperview()
                    let feeds = result.value(forKey: "feed") as? NSDictionary
                    let dataItems = feeds?.value(forKey: "results") as? NSArray
                    if let data = dataItems
                    {
                        if(data.count > 0 )
                        {
                            //Below lines of code write the records in Realm
                            try! self.realm.write() {
                                
                                for item in dataItems ?? [] { // 4
                                    let tempDict = item as? NSDictionary
                                    let newItem = ItemModel()
                                    newItem.name = "\(tempDict?.value(forKey: "name") ?? "")"
                                    newItem.artistName = "\(tempDict?.value(forKey: "artistName") ?? "")"
                                    newItem.url = "\(tempDict?.value(forKey: "url") ?? "")"
                                    newItem.releaseDate = "\(tempDict?.value(forKey: "releaseDate") ?? "")"
                                    newItem.artworkUrl100 = "\(tempDict?.value(forKey: "artworkUrl100") ?? "")"
                                    self.realm.add(newItem)
                                }
                            }
                            self.itemList = self.realm.objects(ItemModel.self)
                            self.collection.reloadData()
                        }
                        
                    }
                }
                
            }, failure: { (error) in
                
                DispatchQueue.main.async {
                    self.loader.removeFromSuperview()
                }
            })
            
        }else {
            
            DispatchQueue.main.async {
                self.loader.removeFromSuperview()
                // No Internet Condition . Giving user option to retry , if realm doesn't contain any data
                if(self.itemList.count == 0)
                {
                    let alert = UIAlertController(title: "No Internet", message: "Please check your Internet Connection", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Retry", style: .default, handler: { action in
                        
                        self.callMusicListApi()
                    })
                    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                    })
                    alert.addAction(ok)
                    alert.addAction(cancel)
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                    
                }
            }
        }
        
    }
    
    // MARK:Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicItemCell
        let row = indexPath.row
        let wrapper = self.itemList[row]
        // Using View model for fetching the Image url and large Image url
        let viewModel = ItemViewModel.init(initwithItemModel:wrapper)
        cell.albumImage.downloadImageFrom(urlString:viewModel.ImageUrl, imageMode: .scaleAspectFill)
        cell.artistNameLbl.text = viewModel.dataModel?.artistName
        cell.albumNameLbl.text = viewModel.dataModel?.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let wrapper = self.itemList[indexPath.row]
        let viewModel = ItemViewModel.init(initwithItemModel:wrapper)
        //Using the Coordinator pattern to open the Detail Page
        AppDelegate.sharedDelegate().appCoordinator.openDetail(model: viewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //Creating header view of collection view
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
        return headerView
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(self.itemList.count > 0)
        {
            return CGSize.init(width: self.view.frame.width, height: 60)
        }
        return CGSize.init(width: self.view.frame.width, height: 0)
    }
    
    // MARK: Scroll View Delegate Method
    
    //This Method makes the Navigation visible when user scrolls the collection view and hides when collection view scroll back to top
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
}
