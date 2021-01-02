//
//  ResultViewController.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 13/12/20.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private(set) var summary = ""
    private(set) var answers = [PresentableAnswer]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = summary
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CorrectAnswerCell.self)
        tableView.register(WrongAnswerCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    fileprivate func correctCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    fileprivate func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.wrongAnswer == nil {
            return correctCell(for: answer)
        } else {
            return wrongAnswerCell(for: answer)
        }
    }
}

