//
//  TaskListViewController.swift
//  ToDoBox
//
//  Created by MacBookPro on 2016. 12. 18..
//  Copyright © 2016년 EDCAN. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView : UITableView!
    
    var tasks : [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ToDo List"
        loadTasks()
        self.tableView.reloadData()
    }
    
    func loadTasks(){
        guard
            let savedDictionaries = UserDefaults.standard.array(forKey : "tasks") as? [[String : Any?]]
        else{
                return
        }
        
        self.tasks = savedDictionaries.map{ task -> Task in
            return Task(
                title : task["title"] as! String,
                memo : task["memo"] as! String?,
                done : task["done"] as! Bool
            )
        }
    }
    
    func saveTasks(){
        let saveDictionaries = self.tasks.map{ task -> [String : Any] in
            var dict : [String : Any] =  [
                "title" : task.title,
                "done" : task.done
            ]
            if let memo = task.memo{
                dict["memo"] = memo
            }
            return dict
        }
        
        UserDefaults.standard.set(saveDictionaries, forKey : "tasks")
        UserDefaults.standard.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue : UIStoryboardSegue, sender : Any?){
        if let navigationController = segue.destination as? UINavigationController,
            let taskEditViewController = navigationController.viewControllers.first as?TaskEditViewController{
                taskEditViewController.taskDidAdd = {
                    newTask in
                    self.tasks.append(newTask)
                    self.saveTasks()
                    self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for : indexPath)
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.memo
        if task.done{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        var task = tasks[i]
        task.done = !task.done
        tasks[i] = task
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

