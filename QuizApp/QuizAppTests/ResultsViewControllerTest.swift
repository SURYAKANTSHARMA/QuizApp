//
//  ResultsViewControllerTest.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 13/12/20.
//

import Foundation
import XCTest
@testable import QuizApp

class ResultsViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        let sut = makeSUT(summary: "a summary", answers: [])
        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_rendersAnswers() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withRightAnswer_renderCorrectAnswerCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
    }
    
    // MARK :- Helpers
    private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeDummyAnswer() -> PresentableAnswer {
        PresentableAnswer(isCorrect: false)
    }
}
