//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 06/12/20.
//

import UIKit
import QuizEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var game: Game<Question<String>,[String], NavigationControllerRouter>?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        
//        let question1 = Question.singleAnswer("What is nationality of surya")
//        let question2 = Question.singleAnswer("What are surya's favourite food")
//        let questions = [question1, question2]
//        
//        let option1 = "Indian"
//        let option2 = "American"
//        let option3 = "Greek"
//        
//        let option4 = "Matar Paneer"
//        let option5 = "Kadi"
//        let option6 = "Alu parantha"
//        
//        let options1 = [option1, option2, option3]
//        let options2 = [option4, option5, option6]
//        
//        let navigationController = UINavigationController()
//        let correctAnswer = [question1: [option1], question2: [option4, option6]]
//        
//        let iOSFactory = iOSViewControllerFactory(questions: questions, options: [question1: options1, question2: options2], correctAnswer: correctAnswer)
//        let router = NavigationControllerRouter(navigationController: navigationController, factory: iOSFactory)
//        
//        self.window = window
//        window.rootViewController = navigationController
//        self.game = startGame(questions: questions, router: router, correctAnswer: correctAnswer)
//        
//        window.makeKeyAndVisible()
    }


}

