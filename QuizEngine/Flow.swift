//
//  Flow.swift
//  QuizEngine
//
//  Created by tokopedia on 04/12/20.
//

import Foundation

class Flow<Question, Answer, R: Router> where R.Answer == Answer, R.Question == Question {
    private let router: R
    private var questions: [Question]
    private var results: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(questions: [Question], router: R, scoring: @escaping(([Question: Answer]) -> Int)) {
        self.router = router
        self.questions = questions
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            self.router.routeTo(result: result())
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
                self.router.routeTo(result: self.result())
            }
         }
     }
    
    private func result() -> Result<Question, Answer> {
        Result(answers: results, score: scoring(results))
    }
}
