//
//  GameRouter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 14.05.2023.
//

import Foundation
import UIKit


class GameRouter: AnyRouter {
    var entry: EntryPoint?
    var questions: [Question]?
    
    static func start() -> AnyRouter {
        let router = GameRouter()
        
        //assign vip
        var view: AnyView = GameViewController()
        var presenter: AnyPresenter = GamePresenter()
        var interactor: AnyInteractor = GameInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interector = interactor
        presenter.view = view
        presenter.router = router
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func nextPage(score: Int) {
        let nextRouter = EndGameRouter.start()
        (nextRouter as? EndGameRouter)?.score = score
        let nextVC = nextRouter.entry
        let viewControllers = [nextVC!]
        entry?.navigationController?.setViewControllers(viewControllers, animated: true)
    }
}
