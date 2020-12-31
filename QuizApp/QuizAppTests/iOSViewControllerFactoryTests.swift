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
    
    func test_questionViewController_createControllerWithQuestion() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        let controller = sut.questionViewController(for: Question.singleAnswer("Q1")) { answer in
            
        } as? QuestionViewController
        XCTAssertNotNil(controller)
    }
    
    func test_questionViewController_createControlleWithOptions() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(for: Question.singleAnswer("Q1")) { answer in
            
        } as? QuestionViewController
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.options, options)
    }
    
    
}
