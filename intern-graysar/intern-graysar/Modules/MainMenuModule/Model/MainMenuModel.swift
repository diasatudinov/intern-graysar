//
//  MainMenuModel.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import Foundation

class PositionData: Identifiable {
    let id = UUID().uuidString
    let items: [MenuItem]
    init(items: [MenuItem]) {
        self.items = items
    }
    
    static func getMockData() -> [MenuItem] {
        [
            MenuItem(image: "item3", name: "Филе индейки Arbuz Select 0,9 кг замороженное", description: "Это наша грудка индейки шоковой заморозки. Натуральная грудка фермерской индейки, выращенной в экологически чистом районе Алматинской области.", additionalDescription: "", country: "Казахстан", storageConditions: "90 дней, -18°С", price: 5770, minQuantity: 1, minQuantityText: "шт"),
            MenuItem(image: "item3", name: "Самса Arbuz Select с рубленой говядиной 500 г", description: "Самса с рубленой говядиной - это вкусное сочетание нежного мяса и хрустящего теста, которое наверняка порадует ваши вкусовые рецепторы.", additionalDescription: "", country: "Казахстан", storageConditions: "90 дней, -18°С", price: 2590, minQuantity: 1, minQuantityText: "шт")
        ]
    }
}


class MenuItem: Identifiable, Equatable {
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        true
    }
    
    let id = UUID().uuidString
    let image: String
    let name: String
    let description: String
    let additionalDescription: String
    let country: String
    let storageConditions: String
    let price: Int
    let minQuantity: Double
    let minQuantityText: String
    var count: Double = 0.0
    var isFavorite: Bool = false
    
    init(image: String, name: String, description: String, additionalDescription: String, country: String, storageConditions: String, price: Int, minQuantity: Double, minQuantityText: String) {
        self.image = image
        self.name = name
        self.description = description
        self.additionalDescription = additionalDescription
        self.country = country
        self.storageConditions = storageConditions
        self.price = price
        self.minQuantity = minQuantity
        self.minQuantityText = minQuantityText

    }
}
