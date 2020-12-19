//
//  Result.swift
//  QuizEngine
//
//  Created by SuryaKant Sharma on 19/12/20.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    public let score: Int
}
