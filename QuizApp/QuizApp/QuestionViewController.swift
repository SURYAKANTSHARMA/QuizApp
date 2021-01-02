//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 06/12/20.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let reuseIdentifier = "Cell"
    private var selection: (([String]) -> Void)? = nil
    private(set) var question: String = ""
    private(set) var options = [String]()
    private(set) var allowMultipleSelection = false
    
    convenience init(question: String, options: [String], allowMultipleSelection: Bool,
                     selection: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
        self.allowMultipleSelection = allowMultipleSelection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        headerLabel.text = question
        tableView.allowsMultipleSelection = allowMultipleSelection
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
        selection?(selectedOptions(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            selection?(selectedOptions(in: tableView))
        }
    }
    
    private func selectedOptions(in tableView: UITableView) -> [String] {
        tableView.indexPathsForSelectedRows?.compactMap { options[$0.row] } ?? []
    }
}
