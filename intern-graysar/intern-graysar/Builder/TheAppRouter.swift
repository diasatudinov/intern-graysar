//
//  TheAppRouter.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit


final class TheAppRouter {
    
    enum Destination {
        case custom(UIViewController)
        case home
        case tabBar
        case basket
        case address
        case productDetails(item: MenuItem, basketManager: BasketManager)
        case payment(basketManager: BasketManager)
    }
    
    enum TransitionType {
        case change
        case push(animated: Bool)
        case present(animated: Bool)
    }
    
    // MARK: - Static
    
    static let shared = TheAppRouter()
    
    // MARK: - Variables
    
    public let navigationController = UINavigationController()
    
    
    
    private var currentControllerName: String?
    
    // MARK: - Init
    
    private init() {
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.isNavigationBarHidden = true
        
        let blankController = UIViewController()
        blankController.view.backgroundColor = UIColor(named: "background")
        self.move(to: .custom(blankController), type: .change)
       
        
        self.move(to: .tabBar, type: .change)
        
        
    }
    
    // MARK: - Methods
    
    
    func back() {
        DispatchQueue.main.async {
            self.navigationController.popViewController(animated: true)
        }
    }
    
    func backFromSheet() {
        DispatchQueue.main.async {
            self.navigationController.dismiss(animated: true)
        }
    }
    
    func move(to destination: TheAppRouter.Destination, type: TheAppRouter.TransitionType) {
        var viewController: UIViewController? {
            switch destination {
            case .custom(let viewController):
                return viewController
                
                
            case .home:
                return MainMenuView()
                
            
            case .basket:
                return BasketView()
            case .tabBar:
                return Builder.createTabBarController()
            case .address:
                let vc = AddressView()
                if let sheet = vc.sheetPresentationController {
                    sheet.detents = [.medium()]
                }
                return vc
                

            case .productDetails(item: let item, basketManager: let basketManager):
                let productDetailsVC = ProductDetailsView()
                productDetailsVC.setup(item: item, basketManager: basketManager)
                return productDetailsVC
            case .payment(basketManager: let basketManager):
                return PaymentViewController(basketManager: basketManager)
            }
        
        }
        
        self.currentControllerName = self.controllerNameText(viewController)
        
        DispatchQueue.main.async {
            if let viewController {
                switch type {
                case .change:
                    self.navigationController.setViewControllers([viewController], animated: false)
                case .push(let animated):
                    self.navigationController.pushViewController(viewController, animated: animated)
                case .present(let animated):
                    self.navigationController.present(viewController, animated: animated)
                }
            }
            
        }
        
        
    }
    
    private func controllerNameText(_ controller: UIViewController?) -> String? {
        if let subsequence = String(describing: controller).split(separator: ":").first,
           let result = subsequence.split(separator: "<").last
        {
            return String(result)
        } else {
            return nil
        }
    }
   
}
