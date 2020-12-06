//
//  QuizEngineTests.swift
//  QuizEngineTests
//
//  Created by tokopedia on 04/12/20.
//

import XCTest
@testable import QuizEngine

class QuizFlowTests: XCTestCase {
    let router = RouterSpy()
    
    func makeSUT(questions: [String]) -> Flow {
        Flow(questions: questions, router: router)
    }
    
    func test_start_withNoQuestion() {
        
         makeSUT(questions: []).start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    
    func test_start_withOneQuestion_routeToQuestion() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(router.routedQuestions.count, 1)
    }
    
    
    func test_start_withOneQuestion_routeToCorrectQuestions() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestion_routeToCorrectQuestion_2() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }

    func test_start_AndAnswertQuestion_with_twoQuestions_routeToSecondQuestions() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    func test_start_AndAnswertQuestion_with_ThreeQuestions_routeToThirdQuestions() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQestion_routeResult() {
        let sut = makeSUT(questions: [])
        sut.start()
        XCTAssertEqual(router.result, [:])
    }
    
    
    func test_start_withOneQestion_routeResult() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.result, ["Q1": "A1"])
    }
    
    func test_start_withTwoQestion_routeResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.result, ["Q1": "A1", "Q2": "A2"])
    }
    
    class RouterSpy: Router {
        
        var routedQuestions: [String] = []
        var answerCallback: Router.AnswerCallback = { _ in }
        var result: [String: String]? = nil
        func routeTo(question: String, answerCallback:  @escaping (String)-> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String : String]) {
            self.result = result
       }
        
    }
}
