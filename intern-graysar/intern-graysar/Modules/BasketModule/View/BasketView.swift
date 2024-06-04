//
//  BasketView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit
import Combine

class BasketView: UIViewController {

    var basketManager: BasketManager!

    
    let layout = UICollectionViewFlowLayout()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            BasketViewCell.self,
            forCellWithReuseIdentifier: "BasketViewCell"
        )
        return collectionView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
        button.setTitle("Перейти к оплате", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let bannerView: UIView = {
        let bannerView = UIView()
        bannerView.backgroundColor = .secondaryLabel
        bannerView.layer.cornerRadius = 20
        return bannerView
    }()
    
    let bannerLabel: UILabel = {
        let bannerLabel = UILabel()
        bannerLabel.text = "Бесплатная доставка от 8000 ₸"
        bannerLabel.textColor = .white
        bannerLabel.textAlignment = .center
        bannerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        return bannerLabel
    }()
    
    var activityIndicator: UIActivityIndicatorView!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        basketManager.delegate = self
        setupViews()
        basketManager.$items.sink { [weak self] _ in
            self?.collectionView.reloadData()
        }.store(in: &cancellables)
        updateBannerVisibility()
    }
    
    @objc private func buttonTapped() {
        print("basketManager.summa", basketManager.summa)
        showActivityIndicator()
        
        // Остановите индикатор через 2 секунды
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.hideActivityIndicator()
            self.button.setTitle("Перейти к оплате \(self.basketManager.summa)", for: .normal)
            TheAppRouter.shared.move(to: .payment, type: .push(animated: true))
        }
       // basketManager.clearCart()
    }
    
    func updateBannerVisibility() {
        if basketManager.items.isEmpty {
            bannerView.isHidden = true
            button.isHidden = true
        } else {
            button.isHidden = false
            bannerView.isHidden = basketManager.summa > 8000
            collectionView.contentInset.top = bannerView.isHidden ? 0 : 50
        }
    }
    
    private func setupViews() {
        if self.basketManager.summa == 0{
            self.button.setTitle("Перейти к оплате", for: .normal)
        } else {
            self.button.setTitle("Перейти к оплате \(self.basketManager.summa)", for: .normal)
        }
        view.addSubview(collectionView)
        view.addSubview(bannerView)
        
        collectionView.addSubview(button)
        bannerView.addSubview(bannerLabel)
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        bannerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerLabel.topAnchor.constraint(equalTo: bannerView.topAnchor),
            bannerLabel.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor),
            bannerLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor),
            bannerLabel.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor)
        ])
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: button.bounds.midX, y: button.bounds.midY)
        activityIndicator.startAnimating()
        
        button.addSubview(activityIndicator)
        button.setTitle("", for: .normal)
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        button.setTitle("Load", for: .normal)
    }

}

extension BasketView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        basketManager.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasketViewCell", for: indexPath) as! BasketViewCell
        
        let item = basketManager.items[indexPath.row]
        cell.setupHostingController(item: item, basketManager: basketManager)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 85)
    }
    
    
}

extension BasketView: BasketDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            if self.basketManager.summa == 0{
                self.button.setTitle("Перейти к оплате", for: .normal)
            } else {
                self.button.setTitle("Перейти к оплате \(self.basketManager.summa)", for: .normal)
            }
            self.collectionView.reloadData()
            self.updateBannerVisibility()
        }
        
    }
    
}
