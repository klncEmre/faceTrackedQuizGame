//
//  GameInteractor.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 14.05.2023.
//

import Foundation
import UIKit
import CoreData


class GameInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func saveScoreToCoreData(){
        guard let presenter = presenter as? GamePresenter else {
            return
        }
        
        // Retrieve the name from UserDefaults
        let userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        
        // Create a managed object context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let scoreEntity = Score(context: context)
        
        scoreEntity.score = Int64(presenter.score)
        scoreEntity.uid = UUID()
        scoreEntity.name = userName
        
        UserDefaults.standard.set(scoreEntity.uid?.uuidString, forKey: "lastScoreId")
        
        // Save the context
        do {
            try context.save()
        } catch {
            print("Failed to save score to CoreData: \(error)")
        }
    }
    
    
}
