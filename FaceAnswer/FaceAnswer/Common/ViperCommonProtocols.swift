//
//  ViperProtocols.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 15.05.2023.
//

import Foundation
protocol AnyView {
    var presenter: AnyPresenter? {get set}
}

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
}




