//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 20/12/20.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: String, answer: @escaping (String) -> Void) -> UIViewController
}

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        let questionVC = factory.questionViewController(for: question, answer: answerCallback)
        navigationController.pushViewController(questionVC, animated: true)
    }
    
    func routeTo(result: Result<String, String>) {
        
    }
}
