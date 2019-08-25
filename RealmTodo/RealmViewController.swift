//
//  RealmViewController.swift
//  RealmTodo
//
//  Created by Geek on 2019/08/23.
//  Copyright © 2019 Takuma Yoshinaga. All rights reserved.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController, UITextFieldDelegate {
    
    var todoTitle: String?

    @IBOutlet weak var realmTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var itemList: Results<TodoModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.saveButton.isEnabled = false   // 初期状態（テキストが空の状態）では"Save"ボタンを無効にする
        if let todoTitle = self.todoTitle {
            self.realmTextField.text = todoTitle
            self.navigationItem.title = "ToDoを編集"
        }
        updateSaveButtonState()
    }
    
    // "Save"ボタンの有効状態を制御するメソッド
    private func updateSaveButtonState() {
        let todoTitle = self.realmTextField.text ?? ""
        self.saveButton.isEnabled = !todoTitle.isEmpty
    }
    
    @IBAction func realmTextFieldChanged(_ sender: Any) {
        self.updateSaveButtonState()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func cancel(_ sender: Any) {
        if self.presentingViewController is UINavigationController {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else {
            return
        }
        self.todoTitle = self.realmTextField.text ?? ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
