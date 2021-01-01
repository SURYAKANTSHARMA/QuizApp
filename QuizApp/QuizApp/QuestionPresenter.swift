//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 01/01/21.
//

import Foundation

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>
    
    var title: String {
        guard let index = questions.firstIndex(of: question) else {
            return ""
        }
        return "Question #\(index+1)"
    }
}
