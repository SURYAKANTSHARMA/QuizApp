//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 30/12/20.
//

import Foundation
import XCTest
import QuizEngine

@testable import QuizApp

class iOSViewControllerFactoryTests: XCTestCase {
    
    let options = ["A1", "A2"]
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    
    func test_questionViewController_createControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(presenter.title, "Question #1")
    }
    
    func test_multipleQuestionViewController_SecondControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(presenter.title, "Question #2")
    }
    
    func test_questionViewController_createControllerWithQuestion_withSingleAnswer() {
        XCTAssertNotNil(makeQuestionViewController())
    }
    
    func test_questionViewController_createControlleWithOptions_singleAnswer() {
        XCTAssertEqual(makeQuestionViewController().options, options)
    }
    
    func test_questionViewController_createControlleWithOptions_singleSelection() {
     
        let controller = makeQuestionViewController()
        
        XCTAssertFalse(controller.allowMultipleSelection)
    }
   
    func test_questionViewController_createControlleWithOptions_multipleSelection() {
        let controller = makeQuestionViewController(question: multipleAnswerQuestion)
        
        XCTAssertTrue(controller.allowMultipleSelection)
    }
    
    func test_resultViewController_createsControllerWithSummaryAndPresentableAnswer() {
       
        let results = makeResults()
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
    }
    
    func test_resultViewController_createsControllerWithTitle() {
       
        let results = makeResults()
        XCTAssertEqual(results.controller.title, "Result")
    }
    
    // MARK: Helpers
    
    func makeSUT(options: Dictionary<Question<String>, [String]> = [:], correctAnswer: Dictionary<Question<String>, [String]> = [:]) -> iOSViewControllerFactory {
        let sut = iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options, correctAnswer: correctAnswer)
        
        return sut
    }
    
    func makeQuestionViewController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {
        makeSUT(options: [question: options]).questionViewController(for: question) { answer in
            
        } as! QuestionViewController
    }
    
    func makeResults() -> (controller: ResultViewController, presenter: ResultsPresenter) {
        let userAnswer = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let orderQuestion = [singleAnswerQuestion, multipleAnswerQuestion]
        let correctAnswer = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let result = Result(answers: userAnswer, score: 2)
        let presenter = ResultsPresenter(result: result, orderQuestion: orderQuestion, correctAnswers: correctAnswer)
        let sut = makeSUT(correctAnswer: correctAnswer)
        let controller = sut.resultViewController(for: result) as! ResultViewController
        
        return (controller, presenter)
    }
}
