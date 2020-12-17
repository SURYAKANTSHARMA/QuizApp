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
        XCTAssertEqual(makeSUT(answers: [makeAnswer(isCorrect: false)]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    
    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "", isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderQuestionText() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        
    }
    
    func test_viewDidLoad_withCorrectAnswer_ConfigureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswerCell_ConfigureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
    }
    // MARK :- Helpers
    private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeAnswer(question: String = "", answer: String = "" , isCorrect: Bool) -> PresentableAnswer {
        PresentableAnswer(question: question, isCorrect: isCorrect, answer: answer)
    }
}
