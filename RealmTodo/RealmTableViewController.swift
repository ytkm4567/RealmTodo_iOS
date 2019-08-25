//
//  RealmTableViewController.swift
//  RealmTodo
//
//  Created by Geek on 2019/08/23.
//  Copyright © 2019 Takuma Yoshinaga. All rights reserved.
//

import UIKit
import RealmSwift

class RealmTableViewController: UITableViewController {

    var itemList: Results<TodoModel>!
    
    // モーダルで"Save"ボタンを押した後の処理
    @IBAction func unwindToRealmList(sender: UIStoryboardSegue) {
        guard let sourceVC = sender.source as? RealmViewController, let todoTitle = sourceVC.todoTitle else {
            return
        }
        // 処理が"編集"の時
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            let realmInstance = try! Realm()
            
            try! realmInstance.write {
                itemList[selectedIndexPath.row].title = todoTitle
            }
        // 処理が"追加"の時
        } else {
            let model: TodoModel = TodoModel()
            model.title = todoTitle
            let realmInstance = try! Realm()
            
            try! realmInstance.write {
                realmInstance.add(model)
            }
        }
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let realmInstance = try! Realm()
        self.itemList = realmInstance.objects(TodoModel.self)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // return self.memos.count
        return self.itemList.count
    }

    // セルがタップされた時の処理
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RealmTableViewCell", for: indexPath)
        let selectedColumn: TodoModel = self.itemList[(indexPath as NSIndexPath).row]
        
        // Configure the cell...
        cell.textLabel?.text = selectedColumn.title
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realmInstance = try! Realm()
            
            try! realmInstance.write {
                realmInstance.delete(itemList[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        // "編集"モーダルへ飛ばす時の処理
        if identifier == "editTodo" {
            let realmVC = segue.destination as! RealmViewController
            realmVC.todoTitle = self.itemList[(self.tableView.indexPathForSelectedRow?.row)!].title
        }
    }
    

}
