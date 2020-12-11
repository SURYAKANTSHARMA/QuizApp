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
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_willRenderNoOption_withOneOptions() {
        XCTAssertEqual(makeSUT(question: "Q1", options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(question: "Q1", options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withOneOption_renderOneOptionText() {
        XCTAssertEqual(makeSUT(question: "Q1", options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(question: "Q1", options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    
    func test_optionSelected_withTwoOptions_notifiesDelegatesWhenSelectionChanges() {
        var answer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { ans in
            answer = ans
        }
        sut.tableView.select(row: 0)
        XCTAssertEqual(answer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(answer, ["A2"])
    }
    
    func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegatesWhenSelectionChanges() {
        var answer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { ans in
            answer = ans
        }
        sut.tableView.select(row: 0)
        XCTAssertEqual(answer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(answer, ["A2"])
    }
    
    //MARK:- Helper
    func makeSUT(question: String = "", options: [String] = [], selection: @escaping ([String]) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
}


private extension UITableView {
    func cell(at index: Int) -> UITableViewCell? {
        dataSource?.tableView(self, cellForRowAt: IndexPath(row: index, section: 0))
    }
    
    func title(at row: Int) -> String? {
        cell(at: row)?.textLabel?.text
    }
    
    func select(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        self.delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
}
