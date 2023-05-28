//
//  File.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation
import UIKit

class LoginViewController : UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    private lazy var textField: UITextField = {
       let tf = UITextField()
       tf.placeholder = "Enter your username here"
       tf.borderStyle = .roundedRect
       tf.keyboardType = .default
       tf.returnKeyType = .done
       tf.clearButtonMode = .whileEditing
       return tf
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "logo.png")
        return iv
    }()
    
    private lazy var myButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    
    public let emptyTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter a username"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    

    @objc func buttonTapped() {
        (presenter as? LoginInputPresenter)?.gameTypePageRequested(name: textField.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200 ).isActive = true
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50 ).isActive = true
        
        view.addSubview(myButton)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          myButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40).isActive = true
          myButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
          myButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(emptyTextFieldLabel)
        emptyTextFieldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyTextFieldLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5).isActive = true
        
        self.view.backgroundColor = UIColor.systemBackground
    }
}
