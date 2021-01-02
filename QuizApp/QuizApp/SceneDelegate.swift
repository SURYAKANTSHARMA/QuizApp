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
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let question1 = Question.singleAnswer("What is nationality of surya")
        let question2 = Question.singleAnswer("What are surya's favourite food")
        let questions = [question1, question2]
        
        let option1 = "Indian"
        let option2 = "American"
        let option3 = "Greek"
        
        let option4 = "Matar Paneer"
        let option5 = "Kadi"
        let option6 = "Alu parantha"
        
        let options1 = [option1, option2, option3]
        let options2 = [option4, option5, option6]
        
        let navigationController = UINavigationController()
        let correctAnswer = [question1: [option1], question2: [option4, option6]]
        
        let iOSFactory = iOSViewControllerFactory(questions: questions, options: [question1: options1, question2: options2], correctAnswer: correctAnswer)
        let router = NavigationControllerRouter(navigationController: navigationController, factory: iOSFactory)
        
        self.window = window
        window.rootViewController = navigationController
        self.game = startGame(questions: questions, router: router, correctAnswer: correctAnswer)
        
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

