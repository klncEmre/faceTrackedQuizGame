//
//  Interactor.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
}

protocol LoginInputInteractor: AnyInteractor {
    func saveName(name: String) -> Void
}
 
class LoginInteractor: LoginInputInteractor {
    let userDefaults = UserDefaults()
    var presenter: AnyPresenter?
    
    func saveName(name: String) {
        print("\(name) saved to userDefaults")
        userDefaults.set(name, forKey: "userName")
    }
}
