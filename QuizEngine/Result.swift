//
//  Result.swift
//  QuizEngine
//
//  Created by SuryaKant Sharma on 19/12/20.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public var answers: [Question: Answer]
    public var score: Int
    
    public init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
}
