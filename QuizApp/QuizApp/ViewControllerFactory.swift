//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 30/12/20.
//

import UIKit
import QuizEngine
// Which controller to be instantiation is decided by factory
// Creation pattern which return dynamic object based upon arguments
protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answer: @escaping (String) -> Void) -> UIViewController
    
    func resultViewController(for result: Result<Question<String>, String>) -> UIViewController
}
