//
//  AddressView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit
import SwiftUI

class AddressView: UIViewController, ViewTodayHostable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        self.add(hostableView: AddressUIView())
        
    }
    
}
