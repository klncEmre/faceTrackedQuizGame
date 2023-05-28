//
//  Presenter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation

protocol QuizTypeSelectionPresenter: AnyPresenter {
    func didSelectGameType(gameType:QuizType) -> Void
}

class TypeSelectionPresenter: QuizTypeSelectionPresenter {
    
    var router: AnyRouter?
    
    var interector: AnyInteractor?
    
    var view: AnyView?
    
    func didSelectGameType(gameType: QuizType) -> Void {
        //call interactor to get quiz list.
        guard let questions = (interector as? TypeInputInteractor)?.getQuestions(quizType: gameType) else { return }
        
        //call router to navigate to game page with this questions
        (router as? QuizTypeSelectionRouter)?.startGame(questions: questions)
    }
}
