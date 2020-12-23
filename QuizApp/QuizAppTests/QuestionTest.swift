//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 21/12/20.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionTest: XCTestCase {
    
    func test_equal_isEqual() {
        let type = "a questionString"
        XCTAssertEqual(Question.singleAnswer(type), Question.singleAnswer(type))
        XCTAssertEqual(Question.multipleAnswer(type), Question.multipleAnswer(type))
    }
    
    func test_notEqual_isNotEqual() {
        let type = "a questionString"
        let otherType = "other Question"
        XCTAssertNotEqual(Question.singleAnswer(type), Question.singleAnswer(otherType))
        XCTAssertNotEqual(Question.singleAnswer(type), Question.multipleAnswer(type))
        XCTAssertNotEqual(Question.multipleAnswer(type), Question.singleAnswer(otherType))
    }
}
