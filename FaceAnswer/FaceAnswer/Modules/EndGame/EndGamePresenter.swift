//
//  EndGamePresenter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 15.05.2023.
//

import Foundation

class EndGamePresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interector: AnyInteractor?
    
    var view: AnyView?
    
    func loadScore() {
        (view as? EndGameViewController)?.scoreLabel.text = "Score: \((router as? EndGameRouter)?.score?.description ?? "error")"
    }
    
    func showScoreBoard(){
        (router as? EndGameRouter)?.navigateToScoreBoard()
    }
    
    func finishGame(){
        (router as? EndGameRouter)?.navigateToLoginPage()
    }
}


