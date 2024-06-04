//
//  PaymentViewController.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit

class PaymentViewController: UIViewController {

    var basketManager: BasketManager
    
    init(basketManager: BasketManager) {
        self.basketManager = basketManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let successLabel: UILabel = {
        let label = UILabel()
        label.text = "Оплата прошла успешно"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        return label
        
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        let chevronImage = UIImage(systemName: "chevron.left")
        button.setImage(chevronImage, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    @objc func backButtonTapped() {
        basketManager.clearCart()
        TheAppRouter.shared.back()
        
    }
    
    func setup() {
        
        view.addSubview(successLabel)
        view.addSubview(backButton)
        
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            successLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
}
