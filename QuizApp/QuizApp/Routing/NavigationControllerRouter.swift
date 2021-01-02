//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 20/12/20.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, answerCallback: @escaping ([String]) -> Void) {
        switch question {
        case .singleAnswer:
            show(factory.questionViewController(for: question, answer: answerCallback))
        case .multipleAnswer:
            let button = UIBarButtonItem(title: "submit", style: .plain, target: nil, action: nil)
            let buttonController = SubmitButtonController(button: button, callback: answerCallback)
            let controller = factory.questionViewController(for: question, answer: { selection in
                buttonController.updateModel(selection)
            })
            
            controller.navigationItem.rightBarButtonItem = button
            show(controller)
        }
    }
    
    func routeTo(result: Result<Question<String>, [String]>) {
       show(factory.resultViewController(for: result))
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callback: ([String]) -> Void
    
    private var model: [String] = []
    
    internal init(button: UIBarButtonItem, callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        setUp()
       
    }
    
    private func setUp() {
        button.isEnabled = false
        button.target = self
        button.action = #selector(fireCallback)
    }
    
    func updateModel(_ model: [String]) {
        self.model = model
        updateButtonState()
    }
    
    func updateButtonState() {
        button.isEnabled = !model.isEmpty
    }
    
    @objc func fireCallback() {
        callback(model)
    }
}
