//
//  TabBarView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit

protocol TabBarViewProtocol: AnyObject{
    func setControllers(controllers: [UIViewController])
}

class TabBarView: UITabBarController {
    
    var presenter: TabBarViewPresenterProtocol!
    private let tabs: [UIImage] = [UIImage(systemName: "house")!, UIImage(systemName: "cart")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabs.enumerated().forEach{
            let offsets: [Double] = [-100, 100]
            let tabButton = createTabBarButton(icon: $0.element, tag: $0.offset, offsetX: offsets[$0.offset], btnSizeH: $0.offset == 1 ? 27:25)
            view.addSubview(tabButton)
        }
        
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemGreen], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let newHeight: CGFloat = 90
        tabBar.frame.size.height = newHeight
        tabBar.frame.origin.y = view.frame.height - newHeight
       
    }
    
    lazy var selectedItem = UIAction { [weak self] sender in
        guard let self = self,
              let sender = sender.sender as? UIButton else {
            return
        }
        
        self.view.subviews.compactMap { $0 as? UIButton }.forEach {
            $0.tintColor = .black
        }
        self.view.tintColor = .systemGreen
        self.selectedIndex = sender.tag
    }
    
}

extension TabBarView {
    private func createTabBarButton(icon: UIImage, tag: Int, offsetX: Double, btnSizeH: Double) -> UIButton {
        
        return {
            let btnSize = 30.0
            $0.frame.size = CGSize(width: btnSize, height: btnSize)
            $0.tag = tag
            $0.setBackgroundImage(icon, for: .normal)
            $0.tintColor = .black
            $0.frame.origin = CGPoint(x: .zero, y: view.frame.height - (btnSize + 52.0))
            $0.center.x = view.center.x + offsetX
            title = ""
            
            return $0
        }(UIButton(primaryAction: selectedItem))
    }
}

extension TabBarView: TabBarViewProtocol{
    func setControllers(controllers: [UIViewController]) {
        setViewControllers(controllers, animated: true)
    }
}
