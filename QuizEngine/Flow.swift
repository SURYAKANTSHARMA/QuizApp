//
//  Flow.swift
//  QuizEngine
//
//  Created by tokopedia on 04/12/20.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
    func routeTo(result: [String: String])
}

class Flow {
    private let router: Router
    private var questions: [String]
    private var results: [String: String] = [:]
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            self.router.routeTo(result: results)
        }
    }
    
    func routeNext(from question: String) -> Router.AnswerCallback {
         { [weak self] answer in
            guard let self = self,
                  let currentIndex = self.questions.firstIndex(of: question) else {
                return
            }
            self.results[question] = answer
            let nextQuestionIndex = currentIndex + 1
            if nextQuestionIndex < self.questions.count {
                let nextQuestion = self.questions[nextQuestionIndex]
                self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion))
            } else {
                .//    self.router.routeTo(result: self.results)
            }
         }
  }
}
