//
//  GamePresenter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 14.05.2023.
//

import Foundation
import UIKit
import AVFoundation
import Vision

protocol GamePresenterProtocol: AnyPresenter {
    func didChooseAnswer(option:Int) -> Void
}

class GamePresenter: GamePresenterProtocol {
    var timer: Timer?
    var secondsRemaining = 20
    var questionIndex = 0
    var score = 0
    
    var horizontalMovements: [Double] = [] //to store last 25 movement data from camera
    var verticalMovements: [Double] = []  //to store last 25 movement data from camera
    let maxMovementsCount = 8
    
    var correctAnswerSound: AVAudioPlayer?
    var wrongAnswerSound: AVAudioPlayer?
    var timeUpSound: AVAudioPlayer?
    
    var horizontalTriggerCount = 0
    var verticalTrigerCount = 0
    let limitTrigger = 3
    
    var blockFlag = false
    var staticCounter = 0
    
    func didChooseAnswer(option: Int) {
        if let correctAnswerSoundURL = Bundle.main.url(forResource: "correct", withExtension: "mp3") {
            correctAnswerSound = try? AVAudioPlayer(contentsOf: correctAnswerSoundURL)
            correctAnswerSound?.prepareToPlay()
        }

        // Load wrong answer sound
        if let wrongAnswerSoundURL = Bundle.main.url(forResource: "wrong", withExtension: "mp3") {
            wrongAnswerSound = try? AVAudioPlayer(contentsOf: wrongAnswerSoundURL)
            wrongAnswerSound?.prepareToPlay()
        }
        if(option == (router as? GameRouter)?.questions?[questionIndex].correctAnswer){
            //answer is correct
            score += 10
            correctAnswerSound?.play()
        } else {
            //answer is wrong
            wrongAnswerSound?.play()
        }
        
        self.verticalTrigerCount = 0
        self.horizontalTriggerCount = 0
        self.horizontalMovements = []
        self.verticalMovements = []
        continueToNextQuestion()
    }
   
    func loadTheFirstQuestion() {
        startTimer()
        (view as? GameViewController)?.questionTextLabel.text = (router as? GameRouter)?.questions?[questionIndex].questionText
        (view as? GameViewController)?.optionFirst.setTitle((router as? GameRouter)?.questions?[questionIndex].optionFirst, for: .normal  )
        (view as? GameViewController)?.optionSecond.setTitle((router as? GameRouter)?.questions?[questionIndex].optionSecond, for: .normal  )
        (view as? GameViewController)?.questionIndexLabel.text = "Question number: " + (questionIndex + 1).description
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
          secondsRemaining -= 1
          if secondsRemaining > 0 {
              // Update the timer label
              (view as? GameViewController)?.timerLabel.text = secondsRemaining.description
          } else {
              //time is up
              if((router as? GameRouter)?.questions?[questionIndex].correctAnswer == 1){
                  (view as? GameViewController)?.optionFirst.backgroundColor = UIColor.green
              } else {
                  (view as? GameViewController)?.optionSecond.backgroundColor = UIColor.green
              }
            
              if let timeUpUrl = Bundle.main.url(forResource: "timeup", withExtension: "mp3") {
                  timeUpSound = try? AVAudioPlayer(contentsOf: timeUpUrl)
                  timeUpSound?.prepareToPlay()
              }
              timeUpSound?.play()
              resetTheTimer()
              DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                  // Code to be executed after 2 seconds
                  self?.continueToNextQuestion()
                  (self?.view as? GameViewController)?.optionFirst.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
                  (self?.view as? GameViewController)?.optionSecond.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
              }
          }
      }
    
    func continueToNextQuestion(){
        if(questionIndex < (((router as? GameRouter)?.questions!.count)! - 1)){
            questionIndex += 1
            resetTheTimer()
            (view as? GameViewController)?.questionTextLabel.text = (router as? GameRouter)?.questions?[questionIndex].questionText
            (view as? GameViewController)?.optionFirst.setTitle((router as? GameRouter)?.questions?[questionIndex].optionFirst, for: .normal  )
            (view as? GameViewController)?.optionSecond.setTitle((router as? GameRouter)?.questions?[questionIndex].optionSecond, for: .normal)
            (view as? GameViewController)?.questionIndexLabel.text = "Question number: " + (questionIndex + 1).description
        } else{
            gameEnded()
        }
        
    }
    
    func resetTheTimer(){
        secondsRemaining = 20
        (view as? GameViewController)?.timerLabel.text = secondsRemaining.description
    }
    
    func gameEnded() {
        timer?.invalidate()
        timer = nil
        (interector as? GameInteractor)?.saveScoreToCoreData()
        (router as? GameRouter)?.nextPage(score: score)
    }
    
    var router: AnyRouter?
    
    var interector: AnyInteractor?
    
    var view: AnyView?
}


extension GamePresenter {
     
     func handleFaceDetection(request: VNRequest, error: Error?) {
         guard let observations = request.results as? [VNFaceObservation] else {
             print("No face observations found.")
             return
         }
         
         for observation in observations {
             // Calculate face movement relative to the screen size
             let movementThresholdHorizontal: CGFloat = 0.11
             let movementThresholdVertical: CGFloat = 0.50
          
             horizontalMovements.append(observation.roll?.doubleValue ?? 0.0)
             verticalMovements.append(observation.pitch?.doubleValue ?? 0.0)
             
             if horizontalMovements.count > maxMovementsCount {
                 horizontalMovements.removeFirst()
             }
             
             if verticalMovements.count > maxMovementsCount {
                 verticalMovements.removeFirst()
             }
             
             let maxHorizontal = horizontalMovements.max() ?? 0.0
             let minHorizontal = horizontalMovements.min() ?? 0.0
             let maxVertical = verticalMovements.max() ?? 0.0
             let minVertical = verticalMovements.min() ?? 0.0
             
             if maxVertical - minVertical > movementThresholdVertical {
                 //vertical signal
                 verticalTrigerCount += 1
             } else if maxHorizontal - minHorizontal > movementThresholdHorizontal {
                //horizontal signal
                 horizontalTriggerCount += 1
             } else {
                 //static case
                 if verticalTrigerCount > 0 {
                     verticalTrigerCount -= 2
                 }
                 if horizontalTriggerCount > 0 {
                     horizontalTriggerCount -= 2
                 }
                 if (staticCounter > 5 && blockFlag == true){
                     blockFlag = false
                 } else {
                     staticCounter += 1
                 }
             }
             if (!blockFlag) {
                 //block flag is designed to wait little bit after face movement found, because the movement needs to and and we need to get static before looking for another movement. Otherwise we will find the same movement again before it ended.
                 
                 if verticalTrigerCount > limitTrigger {
                     //answer is vertical so option 1 is selected
                     print("chosed vertical")
                     blockFlag = true
                     staticCounter = 0
                     DispatchQueue.main.sync {
                         self.didChooseAnswer(option: 1)
                     }
                 } else if horizontalTriggerCount > limitTrigger {
                     //answer is horizontal so option 2 is selected
                     print("chosed horizontal")
                     blockFlag = true
                     staticCounter = 0
                     DispatchQueue.main.sync {
                         self.didChooseAnswer(option: 2)
                     }
                 }
             }
         }
     }
}
