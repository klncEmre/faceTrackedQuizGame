//
//  EndGameView.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 15.05.2023.
//

import Foundation
import UIKit

class EndGameViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    public let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let showScoreboardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Scoreboard", for: .normal)
        button.addTarget(self, action: #selector(showScoreboard), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
          super.viewDidLoad()
          
          view.backgroundColor = .white
          
          view.addSubview(scoreLabel)
          view.addSubview(showScoreboardButton)
          view.addSubview(cancelButton)
          
          NSLayoutConstraint.activate([
              scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              scoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              
              showScoreboardButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 16),
              showScoreboardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
              showScoreboardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
              
              cancelButton.topAnchor.constraint(equalTo: showScoreboardButton.bottomAnchor, constant: 16),
              cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
              cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
              cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
          ])
          
          // Set the end score received from the presenter
        (presenter as? EndGamePresenter)?.loadScore()
          
      }
      
      @objc func showScoreboard() {
          (presenter as? EndGamePresenter)?.showScoreBoard()
      }
      
      @objc func cancel() {
          (presenter as? EndGamePresenter)?.finishGame()
          // Perform actions to cancel and navigate to login page
      }
}
