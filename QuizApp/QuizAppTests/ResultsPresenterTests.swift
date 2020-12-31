//
//  ResultsPresenterTests.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 31/12/20.
//


import XCTest
import QuizEngine
@testable import QuizApp

class ResultsPresenterTests: XCTestCase {
    
    func test_summary_withTwoQuestionAndScoreOne_returnSummary() {
        let answers = [ Question.singleAnswer("Q1"): ["A1"], Question.multipleAnswer("Q2"): ["A2", "A3"]
        ]
        
        let result = Result(answers: answers, score: 1)
        
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswer_withEmptyAnswerAndScoreZero_returnEmptyPresentableAnswer() {
        let answers: Dictionary<Question<String>, [String]> = [:]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        
        XCTAssertEqual(sut.presentableAnswers.count, 0)
    }

    func test_presentableAnswer_withOneSingleAnswer_mapAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A2"]]
        
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertNotNil(sut.presentableAnswers.first!.wrongAnswer)
    }
    
    func test_presentableAnswer_withOneSingleRightAnswer_mapAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A1"]]
        
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
}
