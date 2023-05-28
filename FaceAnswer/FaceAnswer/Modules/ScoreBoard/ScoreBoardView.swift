//
//  ScoreBoardView.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 15.05.2023.
//

import Foundation
import UIKit

class ScoreBoardViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Finish", for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        (presenter as? ScoreBoardPresenter)?.getScoresFromCoreData()
        // Set up the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Add the table view to the view hierarchy
        view.addSubview(tableView)
        
        // Set up auto layout constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -120)
        ])
        
        view.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    @objc func cancel() {
        (presenter as? ScoreBoardPresenter)?.finishGame()
        // Perform actions to cancel and navigate to another page
    }
}
extension ScoreBoardViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter as? ScoreBoardPresenter)?.scores.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let score = (presenter as? ScoreBoardPresenter)?.scores[indexPath.row]
        
        // Set the cell's text label with the score information
        cell.textLabel?.text = "\(score?.name ?? "")  ->  \(score?.score.description ?? "")"
        
        // Check if the current score's UID matches the saved lastScoreId
        if let lastScoreId = UserDefaults.standard.string(forKey: "lastScoreId"),
           score?.uid?.uuidString == lastScoreId {
            // Apply a background color to highlight the last score
            cell.backgroundColor = UIColor.yellow
        } else {
            // Reset the background color for other scores
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
}
