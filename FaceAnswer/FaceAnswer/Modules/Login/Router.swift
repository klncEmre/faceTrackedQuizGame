//
//  Router.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

class LoginRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = LoginRouter()
        
        //assign vip
        var view: AnyView = LoginViewController()
        var presenter: AnyPresenter = LoginPresenter()
        var interactor: AnyInteractor = LoginInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.interector = interactor
        presenter.view = view
        presenter.router = router

        router.entry = view as? EntryPoint
        
        return router
    }
    
    func nextPage() {
        let nextRouter = QuizTypeSelectionRouter.start()
        let nextVC = nextRouter.entry
        entry?.navigationController?.pushViewController(nextVC!, animated: true)
    }
    

}
