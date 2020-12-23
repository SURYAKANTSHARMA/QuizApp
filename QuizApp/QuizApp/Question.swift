//
//  Question.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 22/12/20.
//

import Foundation
enum Question<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .singleAnswer(let type):
            hasher.combine(type.hashValue)
        case .multipleAnswer(let type):
            hasher.combine(type.hashValue)
        }
    }
    
    static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case (.singleAnswer(let a), .singleAnswer(let b)):
            return a == b
        case (.multipleAnswer(let a), .multipleAnswer(let b)):
            return a == b
        default:
            return false
        }
    }
}
