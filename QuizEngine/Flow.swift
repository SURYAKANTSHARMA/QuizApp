//
//  Flow.swift
//  QuizEngine
//
//  Created by tokopedia on 04/12/20.
//

import Foundation

class Flow {
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if !questions.isEmpty {
            router.routeTo(question: "")
        }
    }
}

protocol Router {
    func routeTo(question: String)
}
