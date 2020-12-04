//
//  QuizEngineTests.swift
//  QuizEngineTests
//
//  Created by tokopedia on 04/12/20.
//

import XCTest
@testable import QuizEngine

class QuizFlowTests: XCTestCase {
     
    func test_start_withNoQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routerdQuestionCount, 0)
    }
    
    
    func test_start_withOneQuestion_routeToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routerdQuestionCount, 1)
    }
    
    
    func test_start_withOneQuestion_routeToCorrectQuestions() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    
    class RouterSpy: Router {
        var routerdQuestionCount: Int = 0
        var routedQuestion: String? = nil
        
        func routeTo(question: String) {
            routerdQuestionCount += 1
            routedQuestion = question
        }
    }
}
