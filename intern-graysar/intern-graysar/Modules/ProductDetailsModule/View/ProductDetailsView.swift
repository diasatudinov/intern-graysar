//
//  ProductDetailsView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit
import SwiftUI

class ProductDetailsView: UIViewController, ViewTodayHostable {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        //self.add(hostableView: ProductDetailsUIView())
        
        
    }
    
    public func setup(item: MenuItem, basketManager: BasketManager) {
        
        self.add(hostableView: ProductDetailsUIView(item: item).environmentObject(basketManager))
        //self.addFeel(hostableView: SourcesViewTextOne(image: image, group: group))
    }
    
}
