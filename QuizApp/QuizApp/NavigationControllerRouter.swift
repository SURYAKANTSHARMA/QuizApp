//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 20/12/20.
//

import UIKit
import QuizEngine

// Which controller to be instantiation is decided by factory
// Creation pattern which return dynamic object based upon arguments
protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answer: @escaping (String) -> Void) -> UIViewController
}

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, answerCallback: @escaping (String) -> Void) {
        let questionVC = factory.questionViewController(for: question, answer: answerCallback)
        navigationController.pushViewController(questionVC, animated: true)
    }
    
    func routeTo(result: Result<Question<String>, String>) {
        
    }
}
