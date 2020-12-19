//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by SuryaKant Sharma on 19/12/20.
//

import Foundation
@testable import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var answerCallback: (String) -> Void = { _ in }
    var result: Result<String, String>? = nil
    
    func routeTo(question: String, answerCallback:  @escaping (String)-> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: Result<String, String>) {
        self.result = result
    }
}
