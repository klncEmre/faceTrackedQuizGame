//
//  Router.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get set}
    static func start() -> AnyRouter
}

class LoginRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = LoginRouter()
        
        //assign vip
        var view: AnyView = LoginViewController()
        let presenter: LoginPresenter = LoginPresenter()
        let interactor: LoginInteractor = LoginInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.interector = interactor
        presenter.view = view
        presenter.router = router

        router.entry = view as? EntryPoint
        
        return router
    }
}
