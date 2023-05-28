//
//  Presenter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation


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
        if(name == nil) {
            (view as? LoginViewController)?.emptyTextFieldLabel.isHidden = false
            (view as? LoginViewController)?.emptyTextFieldLabel.text = "Please enter a name first"
        } else if name!.isEmpty || name!.count < 2 || name!.count > 15 || name!.containsEmoji() {
            (view as? LoginViewController)?.emptyTextFieldLabel.isHidden = false
            (view as? LoginViewController)?.emptyTextFieldLabel.text = "Please enter a suitable name first"
        } else {
            (view as? LoginViewController)?.emptyTextFieldLabel.isHidden = true
            //call interactor's saveName method to save name to user defaults.
            (interector as? LoginInteractor)?.saveName(name: user.name!)
            (router as? LoginRouter)?.nextPage()
        }
    }
}

extension String {
    func containsEmoji() -> Bool {
        let emojiPattern = "[\\p{Emoji}]"
        return self.range(of: emojiPattern, options: .regularExpression) != nil
    }
}
