//
//  Builder.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit

protocol BuilderProtocol{
    static func getMainMenuController() -> UIViewController
    static func createTabBarController() -> UIViewController
    
    //MARK: ViewControllers
    static func createMainMenuController() -> UIViewController
    static func createBasketController() -> UIViewController

}

class Builder: BuilderProtocol {
    
    static var basketManager = BasketManager()
    
    static func getMainMenuController() -> UIViewController {
        MainMenuView()
    }
    
    static func createTabBarController() -> UIViewController {
        let tabBarView = TabBarView()
        let presenter = TabBarViewPresenter(view: tabBarView)
        tabBarView.presenter = presenter
        return tabBarView
    }
    
    
    
    static func createMainMenuController() -> UIViewController {
        let mainMenuView = MainMenuView()
        let presenter = MainMenuPresenter(view: mainMenuView)
        mainMenuView.title = "Главная"
        mainMenuView.basketManager = basketManager
        mainMenuView.presenter = presenter
        
        return UINavigationController(rootViewController: mainMenuView)
    }
    
    static func createBasketController() -> UIViewController {
        let basketView = BasketView()
        basketView.basketManager = basketManager
        basketView.title = "Корзина"
        return basketView
    }
}
