//
//  QuizAppTests.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 06/12/20.
//

import XCTest
@testable import QuizApp

class QuizViewControllerTests: XCTestCase {
    
    func test_viewDidLoad_rendersQuestionHeaderText() {
        let sut = QuestionViewController(question: "Q1", options: [])
        _ = sut.view
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_willRenderNoOption_withZeroOptions() {
        let sut = QuestionViewController(question: "Q1",options: [])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_willRenderNoOption_withOneOptions() {
        let sut = QuestionViewController(question: "Q1",options: ["A1"])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withOneOption_renderOneOptionText() {
        let sut = QuestionViewController(question: "Q1",options: ["A1"])
        _ = sut.view
        
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
}
