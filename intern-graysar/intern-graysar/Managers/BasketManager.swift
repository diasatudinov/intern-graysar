//
//  BasketManager.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import SwiftUI

protocol BasketDelegate: AnyObject {
    func reloadData()
}

class BasketManager: ObservableObject {
    @Published var items: [MenuItem] = []
    @Published var summa: Double = 0.0
        
    weak var delegate: BasketDelegate?
    
    func addToSumma(summa: Double) {
        self.summa += summa
        delegate?.reloadData()
    }
    
    func subFromSumma(summa: Double) {
        self.summa -= summa
        delegate?.reloadData()
    }
    
    func favoriteItemToggle(_ item: MenuItem) {
        item.isFavorite.toggle()
        
    }
    
    func addItem(_ item: MenuItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].count += item.minQuantity
        } else {
            item.count = item.minQuantity
            items.append(item)
        }
    }
    
    func removeItem(_ item: MenuItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if items[index].count > item.minQuantity {
                items[index].count -= item.minQuantity
            } else {
                item.count = 0
                items.remove(at: index)
            }
        }
    }
    
    func removeFullItem(_ item: MenuItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            summa -= item.count * Double(item.price)
            items.remove(at: index)
            item.count = 0
            delegate?.reloadData()
            
        }
    }
    
    func clearCart() {
        summa = 0.0
        items.removeAll()
    }
}

