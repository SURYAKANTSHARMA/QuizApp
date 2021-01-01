//
//  QuestionPresenterTest.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 01/01/21.
//

import QuizEngine
import XCTest
@testable import QuizApp

class QuestionPresenterTest: XCTestCase {
    let question = Question.singleAnswer("Q1")
    let secondQuestion = Question.singleAnswer("Q2")
    
    func test_title_forFirstQuestion() {
        let sut = QuestionPresenter(questions: [question], question: question)
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion() {
       
        let sut = QuestionPresenter(questions: [question, secondQuestion], question: secondQuestion)
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    
    func test_title_forUnexistQuestion_shouldReturnEmptyTitle() {
        let unexistingQuestion = Question.singleAnswer("Q21")
        let sut = QuestionPresenter(questions: [question, secondQuestion], question: unexistingQuestion)
        XCTAssertEqual(sut.title, "")
    }
    
}
