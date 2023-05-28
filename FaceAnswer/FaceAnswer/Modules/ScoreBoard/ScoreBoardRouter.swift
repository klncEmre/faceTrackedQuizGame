//
//  ScoreBoardRouter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 15.05.2023.
//

import Foundation


class ScoreBoardRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = ScoreBoardRouter()
        
        //assign vip
        var view: AnyView = ScoreBoardViewController()
        var presenter: AnyPresenter = ScoreBoardPresenter()
        var interactor: AnyInteractor = ScoreBoardInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interector = interactor
        presenter.view = view
        presenter.router = router

        router.entry = view as? EntryPoint
        
        return router
    }
    
    func finishGame(){
        let nextRouter = LoginRouter.start()
        let nextVC = nextRouter.entry
        let viewControllers = [nextVC!]
        entry?.navigationController?.setViewControllers(viewControllers, animated: true)
    }
}
