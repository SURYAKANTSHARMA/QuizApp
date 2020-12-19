//
//  Game.swift
//  QuizEngine
//
//  Created by SuryaKant Sharma on 19/12/20.
//

import Foundation

public class Game <Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswer: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: {
        scoring($0, correctAnswer: correctAnswer)
    })
    flow.start()
    return Game(flow: flow)
}

private func scoring<Question: Hashable, Answer: Equatable>(_ answers: [Question: Answer], correctAnswer: [Question: Answer]) -> Int {
     return answers.reduce(0) { score, tuple in
        let currentScoreCounter = correctAnswer[tuple.key] == tuple.value ? 1 : 0
        return score + currentScoreCounter
    }
}
