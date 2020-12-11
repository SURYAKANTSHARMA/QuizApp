//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 06/12/20.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var question = ""
    private var options = [String]()
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private let reuseIdentifier = "Cell"
    private var selection: (([String]) -> Void)? = nil
    
    convenience init(question: String, options: [String], selection: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = question
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?([options[indexPath.row]])
    }
}
