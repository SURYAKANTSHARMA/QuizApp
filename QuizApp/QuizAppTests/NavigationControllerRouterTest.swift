//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 20/12/20.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTests: XCTestCase {
    
    let navigationController = NoAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")

    lazy var sut: NavigationControllerRouter = {
        NavigationControllerRouter(navigationController: self.navigationController, factory: self.factory)
    }()
    
    func test_routeToQuestion_showQuestionController() {
        //given
        let firstVC = UIViewController()
        let secondVC = UIViewController()
        
        factory.stub(question:  singleAnswerQuestion, with: firstVC)
        factory.stub(question:  Question.singleAnswer("Q2"), with: secondVC)
        
        // when
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })
        // then
        XCTAssertEqual(navigationController.viewControllers, [firstVC, secondVC])
    }
    
    func test_routeToResult_showResultController() {
        class VC: UIViewController { }
        //given
        let firstVC = UIViewController()
        let secondVC = VC()

        let result = Result(answers: [singleAnswerQuestion: ["A1"]], score: 1)
        let secondResult = Result(answers: [Question.singleAnswer("Q2"): ["A2"]], score: 2)

        factory.stub(answer: result, with: firstVC)
        factory.stub(answer: secondResult, with: secondVC)

        // when
        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)
        
        // then
        XCTAssertEqual(navigationController.viewControllers, [firstVC, secondVC])
    }
    
    func test_routeToQuestion_singleAnswer_answerCallback_progressToNextQuestion() {
      
        // given
        var callbackFired = false
        let question = singleAnswerQuestion
        
        factory.stub(question: question, with: UIViewController())
        // when
        sut.routeTo(question: question, answerCallback: { _ in callbackFired = true })
        factory.answerCallbacks[singleAnswerQuestion]?(["anything"])
       
        // then
        XCTAssertTrue(callbackFired)
    }
    
    func test_routeToQuestion_singleAnswer_answerCallback_doesNotConfigureSubmitButton() {
      
        // given
        let question = singleAnswerQuestion
        let controller = UIViewController()
        factory.stub(question: question, with: UIViewController())
        // when
        sut.routeTo(question: question, answerCallback: { _ in  })
        
        // then
        XCTAssertNil(controller.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToQuestion_multipleAnswer_answerCallback_doesNotProgressToNextQuestion() {
      
        // given
        var callbackFired = false
        
        factory.stub(question: multipleAnswerQuestion, with: UIViewController())
        // when
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in callbackFired = true })
        factory.answerCallbacks[multipleAnswerQuestion]?(["anything"])
       
        // then
        XCTAssertFalse(callbackFired)
    }
    
    func test_routeToQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {
        let controller = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: controller)
        
        // when
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        
        // then
        XCTAssertNotNil(controller.navigationItem.rightBarButtonItem)
    }
    

    func test_routeToQuestion_multipleAnswer_submitButtonWhenNoAnswerSelected() {
        let controller = UIViewController()

        factory.stub(question: multipleAnswerQuestion, with: controller)
        
        // when
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        
        // then
        XCTAssertFalse(controller.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routeToQuestion_multipleAnswer_submitButtonGetEnableWhenAtLeastOneAnswerSelected() {
        let controller = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: controller)
        
        // when
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        
        XCTAssertFalse(controller.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallbacks[multipleAnswerQuestion]?(["anything"])
        
        // then
        XCTAssertTrue(controller.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routeToQuestion_multipleAnswer_submitButtonFiresCallback() {
        let controller = UIViewController()
        var callbackFired = false
        
        factory.stub(question: multipleAnswerQuestion, with: controller)
        
        // when
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in  callbackFired = true
        })
        
        factory.answerCallbacks[multipleAnswerQuestion]?(["A1"])
        XCTAssertTrue(controller.navigationItem.rightBarButtonItem!.isEnabled)
        
        // Need to press the button Submit
        let button = controller.navigationItem.rightBarButtonItem!
        button.simulateTap()
        XCTAssertTrue(callbackFired)
    }
}

class ViewControllerFactoryStub: ViewControllerFactory {
    var stubbedQuestions = [Question<String>: UIViewController]()
    var stubbedAnswers = [Result<Question<String>, [String]>: UIViewController]()
    
    var answerCallbacks = [Question<String>: ([String])->Void]()
    
    func stub(question: Question<String>, with viewController: UIViewController) {
        stubbedQuestions[question] = viewController
    }
    
    func stub(answer: Result<Question<String>, [String]>, with viewController: UIViewController) {
        stubbedAnswers[answer] = viewController
    }
    
    func questionViewController(for question: Question<String>, answer: @escaping ([String]) -> Void) -> UIViewController {
        answerCallbacks[question] = answer
        return stubbedQuestions[question] ?? UIViewController()
    }
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return stubbedAnswers[result] ?? UIViewController()
    }
}

class NoAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}

extension Result: Hashable {
    public var hashValue: Int { return score }
    
    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
