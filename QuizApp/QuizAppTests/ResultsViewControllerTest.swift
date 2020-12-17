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
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    
   func test_viewDidLoad_withCorrectAnswer_renderQuestionText() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1")])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        
    }
    
    func test_viewDidLoad_withCorrectAnswer_ConfigureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1")])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswerCell_ConfigureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "A2")])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "A2")
    }
    // MARK :- Helpers
    private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil) -> PresentableAnswer {
        PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
}
