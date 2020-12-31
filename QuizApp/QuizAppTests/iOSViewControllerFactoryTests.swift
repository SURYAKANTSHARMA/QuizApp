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
     
        let controller = makeQuestionViewController(question: .multipleAnswer("multiple answer question"))
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: Helpers
    
    func makeSUT() -> iOSViewControllerFactory {
        let question = Question.singleAnswer("Q1")
        let multipleAnswerQuestion = Question.multipleAnswer("multiple answer question")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options,
                                                     multipleAnswerQuestion: options])
        
        return sut
    }
    
    func makeQuestionViewController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {
        makeSUT() .questionViewController(for: question) { answer in
            
        } as! QuestionViewController
    }
}
