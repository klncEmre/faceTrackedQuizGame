//
//  ScoreBoardPresenter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 15.05.2023.
//

import Foundation
import UIKit
import CoreData

class ScoreBoardPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interector: AnyInteractor?
    
    var view: AnyView?
    
    var scores: [Score] = []
    
    func finishGame(){
        (router as? ScoreBoardRouter)?.finishGame()
    }
    
    func getScoresFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        // Create a fetch request for the Question entity
        let fetchRequest: NSFetchRequest<Score> = Score.fetchRequest()

        // Fetch the Question entities from Core Data
        do {
           scores = try context.fetch(fetchRequest)
           scores.sort { $0.score > $1.score }
        } catch let error as NSError {
           print("Could not fetch scores: \(error.localizedDescription)")
        }
    }
    
}

