//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 20/12/20.
//

import UIKit
import XCTest
@testable import QuizApp

class NavigationControllerRouterTests: XCTestCase {
    
    let navigationController = NoAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    
    lazy var sut: NavigationControllerRouter = {
        NavigationControllerRouter(navigationController: self.navigationController, factory: self.factory)
    }()
    
    func test_routeToQuestion_showQuestionController() {
        //given
        let firstVC = UIViewController()
        let secondVC = UIViewController()
        
        factory.stub(question: "Q1", with: firstVC)
        factory.stub(question: "Q2", with: secondVC)
        
        // when
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        // then
        XCTAssertEqual(navigationController.viewControllers, [firstVC, secondVC])
    }
    
    func test_routeToQuestion_presentRightQuestionControllerWithRightCallback() {
        // given
        var callbackFired = false
       
        // when
        sut.routeTo(question: "Q1", answerCallback: { _ in callbackFired = true })
        factory.answerCallbacks["Q1"]?("anything")
       
        // then
        XCTAssertTrue(callbackFired)
    }
}

class ViewControllerFactoryStub: ViewControllerFactory {
    
    var stubbedQuestions = [String: UIViewController]()
    var answerCallbacks = [String: (String)->Void]()
    
    func stub(question: String, with viewController: UIViewController) {
        stubbedQuestions[question] = viewController
    }
    
    func questionViewController(for question: String, answer: @escaping (String) -> Void) -> UIViewController {
        answerCallbacks[question] = answer
        return stubbedQuestions[question] ?? UIViewController()
    }
}

class NoAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}
