//
//  Flow.swift
//  QuizEngine
//
//  Created by tokopedia on 04/12/20.
//

import Foundation

protocol Router {
    associatedtype Answer
    associatedtype Question: Hashable
    typealias AnswerCallback = (Answer) -> Void
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: [Question: Answer])
}

class Flow<Question: Hashable, Answer, R: Router> where R.Answer == Answer, R.Question == Question {
    private let router: R
    private var questions: [Question]
    private var results: [Question: Answer] = [:]
    
    init(questions: [Question], router: R) {
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
    
    func routeNext(from question: Question) -> R.AnswerCallback {
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
                  self.router.routeTo(result: self.results)
            }
         }
     }
}
