//
//  AppCoordinator.swift
//  AppleMusicApp
//
//  Created by dedicated developer on 18/07/22.
//

import Foundation
import UIKit

protocol AppFlow: class {
    func openDetail(model:ItemViewModel)
}

class AppCoordinator {
    
    // MARK: - Properties
    
    private let navigationController = UINavigationController()
    // MARK: - Set Root View Controller
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Open Respective Pages
    
    func start() {
        
        let firstVC = MusicListVC()
        self.navigationController.pushViewController(firstVC, animated: true)
    }
    
    func openDetail(model:ItemViewModel){
        
        let detailVC = MusicDetailVC()
        detailVC.dataModel = model
        self.navigationController.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Back Action
    
    func backtoPreviousPage(){
        self.navigationController.popViewController(animated: true)
    }
    
}
