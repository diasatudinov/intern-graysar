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
    var sumCounter = 0
    
    weak var delegate: BasketDelegate?
    
    func addToSumma(_ item: MenuItem, summa: Double) {
        if item.minQuantity == 0 {
            if sumCounter < 1 {
                self.summa += summa
                sumCounter = 1
            }
        } else {
            self.summa += summa
        }
        delegate?.reloadData()
    }
    
    func subFromSumma(_ item: MenuItem, summa: Double) {
        if item.minQuantity == 0 {
            if sumCounter > 0 {
                self.summa -= summa
                sumCounter = 0
            }
        } else {
            self.summa -= summa
        }
        delegate?.reloadData()
    }
    
    func favoriteItemToggle(_ item: MenuItem) {
        item.isFavorite.toggle()
        
    }
    
    func addItem(_ item: MenuItem) {
        if item.minQuantity == 0 {
            print("ADDITEM IF 0")
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                items[index].count = 1
                items.append(item)
            } else {
                item.count = 1
                items.append(item)
            }
        } else {
            print("ADDITEM IF NOT 0")
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                items[index].count += item.minQuantity
            } else {
                item.count = item.minQuantity
                items.append(item)
            }
        }
    }
    
    func removeItem(_ item: MenuItem) {
        if item.minQuantity == 0 {
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                if items[index].count > item.minQuantity {
                    items[index].count = 0
                    items.remove(at: index)
                } else {
                    item.count = 0
                    items.remove(at: index)
                }
            }
        } else {
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                if items[index].count > item.minQuantity {
                    items[index].count -= item.minQuantity
                } else {
                    item.count = 0
                    items.remove(at: index)
                }
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
        items.forEach { item in
            item.count = 0.0
        }
        items.removeAll()
        sumCounter = 0
        summa = 0.0
        delegate?.reloadData()
    }
}

