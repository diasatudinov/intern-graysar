//
//  MainMenuPresenter.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import UIKit

protocol MainMenuPresenterProtocol: AnyObject {
    init(view: MainMenuViewProtocol)
    var datas: [MenuItem]? {get set}
    func getData()
}

class MainMenuPresenter {
    weak var view: MainMenuViewProtocol?
    var datas: [MenuItem]?
    required init(view: MainMenuViewProtocol) {
        self.view = view
        getData()
    }
}

extension MainMenuPresenter: MainMenuPresenterProtocol {
    func getData() {
        self.datas = PositionData.getMockData()
        view?.showData()
    }
}
