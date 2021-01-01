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
    let singleQuestion = Question.singleAnswer("Q1")
    let multipleQuestion = Question.multipleAnswer("Q2")
    
    func test_summary_withTwoQuestionAndScoreOne_returnSummary() {
        let answers = [singleQuestion: ["A1"], multipleQuestion: ["A2", "A3"]
        ]
        
        let result = Result(answers: answers, score: 1)
        let orderQuestion = [singleQuestion, multipleQuestion]
        let sut = ResultsPresenter(result: result, orderQuestion: orderQuestion, correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswer_withEmptyAnswerAndScoreZero_returnEmptyPresentableAnswer() {
        let answers: Dictionary<Question<String>, [String]> = [:]
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, orderQuestion: [], correctAnswers: [:])
        
        XCTAssertEqual(sut.presentableAnswers.count, 0)
    }

    func test_presentableAnswer_withOneSingleAnswer_mapAnswer() {
        let answers = [singleQuestion: ["A1"]]
        let correctAnswers = [singleQuestion: ["A2"]]
        
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, orderQuestion: [singleQuestion], correctAnswers: correctAnswers)
        
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertNotNil(sut.presentableAnswers.first!.wrongAnswer)
    }
    
    func test_presentableAnswer_withOneMultipleAnswer_mapAnswer() {
        let answers = [multipleQuestion: ["A1", "A3"]]
        let correctAnswers = [multipleQuestion: ["A1", "A3"]]
        
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, orderQuestion: [multipleQuestion], correctAnswers: correctAnswers)
        
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1,A3")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
    
    
    func test_presentableAnswer_withTwoQuestionMapOrderAnswer() {
        let answers = [singleQuestion: ["A1"], multipleQuestion: ["A1", "A4"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A1"],Question.multipleAnswer("Q2"): ["A1", "A4"]]
        let orderQuestion = [Question.singleAnswer("Q1"), Question.multipleAnswer("Q2")]

        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, orderQuestion: orderQuestion, correctAnswers: correctAnswers)


        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")

        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
        
        
        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")

        XCTAssertEqual(sut.presentableAnswers.last!.answer, "A1,A4")
        XCTAssertNil(sut.presentableAnswers.last!.wrongAnswer)
    }
}
