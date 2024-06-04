//
//  MainMenuView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit
import SwiftUI

protocol MainMenuViewProtocol: AnyObject {
    func showData()
    
}

class MainMenuView: UIViewController, ViewTodayHostable {

    var presenter: MainMenuPresenterProtocol!
    var basketManager: BasketManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Главная"
        navigationController?.navigationBar.isHidden = true
        if let items = presenter.datas{
            self.add(hostableView: MainMenuUIView(items: items).environmentObject(basketManager))
        }
        
    }

}

extension MainMenuView: MainMenuViewProtocol {
    func showData() {
        
    }
    
}

class MainMenuCELLView: UIViewController, ViewTodayHostable {

    
    var presenter: MainMenuPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.add(hostableView: ProductCellUIView())
    }

}
