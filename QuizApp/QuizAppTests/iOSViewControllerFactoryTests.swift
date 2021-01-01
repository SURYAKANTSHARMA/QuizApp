//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 30/12/20.
//

import Foundation
import XCTest
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
        _ = controller.view
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
   
    func test_questionViewController_createControlleWithOptions_multipleSelection() {
        let controller = makeQuestionViewController(question: multipleAnswerQuestion)
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: Helpers
    
    func makeSUT() -> iOSViewControllerFactory {
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: [singleAnswerQuestion: options,
                                                     multipleAnswerQuestion: options])
        
        return sut
    }
    
    func makeQuestionViewController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {
        makeSUT().questionViewController(for: question) { answer in
            
        } as! QuestionViewController
    }
}
