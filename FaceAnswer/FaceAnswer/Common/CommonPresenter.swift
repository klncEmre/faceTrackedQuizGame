//
//  File.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 15.05.2023.
//

import Foundation
protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interector: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
}
