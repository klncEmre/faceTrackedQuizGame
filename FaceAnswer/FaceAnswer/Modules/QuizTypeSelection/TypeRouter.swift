//
//  Router.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation
import UIKit


protocol QuizTypeRouterProtocol: AnyRouter{
    func startGame(questions: [Question]) -> Void
}

class QuizTypeSelectionRouter: QuizTypeRouterProtocol {
   
    func startGame(questions: [Question]) {
        
        let nextRouter = GameRouter.start()
        (nextRouter as? GameRouter)?.questions = questions //pass questions to next router
        let nextVC = nextRouter.entry
        let viewControllers = [nextVC!]
        entry?.navigationController?.setViewControllers(viewControllers, animated: true)
    }
    

    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = QuizTypeSelectionRouter()
        
        //assign vip
        var view: AnyView = TypeSelectionViewController()
        var presenter: AnyPresenter = TypeSelectionPresenter()
        var interactor: AnyInteractor = TypeSelectionInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interector = interactor
        presenter.view = view
        presenter.router = router

        router.entry = view as? EntryPoint
        
        return router
    }
    
    func nextPage() {
    }
    
}
