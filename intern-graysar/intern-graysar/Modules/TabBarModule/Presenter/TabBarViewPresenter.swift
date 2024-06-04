//
//  TabBarViewPresenter.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit

protocol TabBarViewPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
    func buildTabBar()
     
}

class TabBarViewPresenter{
    //MARK: variables
    weak var view: TabBarViewProtocol?
    //MARK: functions
    required init(view: TabBarViewProtocol) {
        self.view = view
        self.buildTabBar()
    }
    
    
    
    
}

extension TabBarViewPresenter: TabBarViewPresenterProtocol {
    
    func buildTabBar() {
        let mainMenu = Builder.createMainMenuController()
        let basket = Builder.createBasketController()
        
        self.view?.setControllers(controllers: [mainMenu, basket])
    }
}
