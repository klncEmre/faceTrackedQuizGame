//
//  Presenter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interector: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
}

protocol LoginInputPresenter: AnyPresenter {
    func gameTypePageRequested(name: String?) -> Void
}

class LoginPresenter: LoginInputPresenter {
    
    var router: AnyRouter?
    
    var interector: AnyInteractor?
    
    var view: AnyView?
    
    var user: User = User(name: nil)
    
    func gameTypePageRequested(name: String?) {
        //control user name, if it is ok call saveName for interactor
        user.name = name
        
        if(name == nil || name == "") {
            (view as? LoginViewController)?.emptyTextFieldLabel.isHidden = false
        } else {
            (view as? LoginViewController)?.emptyTextFieldLabel.isHidden = true
            //call interactor's saveName method to save name to user defaults.
            (interector as? LoginInteractor)?.saveName(name: user.name!)
        }
    }
}
