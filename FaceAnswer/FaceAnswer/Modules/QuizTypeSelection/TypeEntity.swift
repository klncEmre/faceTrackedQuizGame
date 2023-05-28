//
//  Entity.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation

enum QuizType {
    case history
    case art
    case random
}

struct Question: Codable {
    let questionText: String
    let optionFirst: String
    let optionSecond: String
    let correctAnswer: Int
}
