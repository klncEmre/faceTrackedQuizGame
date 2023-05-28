//
//  EndGameRouter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 15.05.2023.
//

import Foundation

class EndGameRouter: AnyRouter {
    var entry: EntryPoint?
    var score: Int?
    
    static func start() -> AnyRouter {
        let router = EndGameRouter()
        
        //assign vip
        var view: AnyView = EndGameViewController()
        var presenter: AnyPresenter = EndGamePresenter()
        var interactor: AnyInteractor = EndGameInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interector = interactor
        presenter.view = view
        presenter.router = router

        router.entry = view as? EntryPoint
        
        return router
    }
    
    func navigateToScoreBoard() {
        let nextRouter = ScoreBoardRouter.start()
        let nextVC = nextRouter.entry
        let viewControllers = [nextVC!]
        entry?.navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    func navigateToLoginPage(){
        let nextRouter = LoginRouter.start()
        let nextVC = nextRouter.entry
        let viewControllers = [nextVC!]
        entry?.navigationController?.setViewControllers(viewControllers, animated: true)
    }
}
