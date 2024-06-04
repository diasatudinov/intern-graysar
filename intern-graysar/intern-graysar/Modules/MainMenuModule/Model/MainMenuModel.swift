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
            MenuItem(image: "item 1", name: "Футболка черная без принта", description: "Стильная футболка с оригинальным принтом. Отличный выбор для повседневной носки", additionalDescription: "", country: "Казахстан", storageConditions: "Хранить в тёмном месте при комнатной температуре. Беречь от влаги и прямых солнечных лучей.", price: 14990, minQuantity: 1, minQuantityText: "/шт"),
            MenuItem(image: "item 3", name: "Английский язык для начинающих", description: "Курс английского языка для тех, кто начинает изучать язык с нуля. Включает в себя основы грамматики, лексики и разговорной практики. Занятия проходят онлайн или офлайн. Есть возможность выбора преподавателя. В конце курса выдаётся сертификат", additionalDescription: "", country: "Казахстан", storageConditions: "", price: 29990, minQuantity: 0, minQuantityText: "")
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
