//
//  CommonRouter.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 15.05.2023.
//

import Foundation
protocol AnyRouter {
    var entry: EntryPoint? {get set}
    static func start() -> AnyRouter
//    func nextPage() -> Void
}

