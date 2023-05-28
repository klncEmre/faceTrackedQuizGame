//
//  File.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation
import UIKit



class TypeSelectionViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Pick your questions pool"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add UI elements to allow user to select a quiz type
        let historyButton = UIButton(type: .system)
        historyButton.setTitle("History", for: .normal)
        historyButton.setTitleColor(.white, for: .normal)
        historyButton.backgroundColor = .systemBlue
        historyButton.layer.cornerRadius = 8
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)

        let artButton = UIButton(type: .system)
        artButton.setTitle("Art", for: .normal)
        artButton.setTitleColor(.white, for: .normal)
        artButton.backgroundColor = .systemBlue
        artButton.layer.cornerRadius = 8
        artButton.addTarget(self, action: #selector(artButtonTapped), for: .touchUpInside)

        let randomButton = UIButton(type: .system)
        randomButton.setTitle("Random", for: .normal)
        randomButton.setTitleColor(.white, for: .normal)
        randomButton.backgroundColor = .systemBlue
        randomButton.layer.cornerRadius = 8
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [historyButton, artButton, randomButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        view.addSubview(stackView)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            stackView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -100).isActive =  true
    }
    
    @objc func historyButtonTapped() {
        (presenter as? QuizTypeSelectionPresenter)?.didSelectGameType(gameType: .history)
    }
    
    @objc func artButtonTapped() {
        (presenter as? QuizTypeSelectionPresenter)?.didSelectGameType(gameType: .art)
    }
    
    @objc func randomButtonTapped() {
        (presenter as? QuizTypeSelectionPresenter)?.didSelectGameType(gameType: .random)
    }
}


