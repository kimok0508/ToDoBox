//
//  TaskEditViewController.swift
//  ToDoBox
//
//  Created by MacBookPro on 2016. 12. 19..
//  Copyright © 2016년 EDCAN. All rights reserved.
//

import UIKit

class TaskEditViewController : UIViewController{
    @IBOutlet var titleInput : UITextField!
    @IBOutlet var memoInput : UITextView!
    
    var taskDidAdd : ((Task) -> Void)?
    
    @IBAction func cancelButtonDidTap(){
        guard
            let title = titleInput.text, !title.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        let cancelAlertController = UIAlertController(
            title : "Attention!",
            message : "You really want to cancel it?",
            preferredStyle : .alert
        )
        let confirmAction = UIAlertAction(
            title : "I want to cancel it",
            style: .destructive,
            handler: { _ in
                self.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(
            title : "Cancel action",
            style : .default,
            handler : nil
        )
        
        cancelAlertController.addAction(cancelAction)
        cancelAlertController.addAction(confirmAction)
        self.present(cancelAlertController, animated : true, completion : nil)
    }
    
    @IBAction func saveButtonDidTap(){
        guard let title = titleInput.text, !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            shakeAnimate(view: titleInput)
            return
        }
        
        let newTask = Task(title : title, memo : memoInput.text)
        self.taskDidAdd?(newTask)
        self.dismiss(animated : true, completion : nil)
    }
    
    func shakeAnimate(view : UIView){
        UIView.animate(withDuration : 0.05, animations : {
            view.frame.origin.x -= 5
        }, completion : { _ in
            UIView.animate(withDuration : 0.1, animations : {
                view.frame.origin.x += 10
            }, completion : { _ in
                UIView.animate(withDuration : 0.1, animations : {
                    view.frame.origin.x -= 10
                }, completion : { _ in
                    UIView.animate(withDuration : 0.1, animations : {
                        view.frame.origin.x += 10
                    }, completion : { _ in
                        UIView.animate(withDuration : 0.05, animations : {
                            view.frame.origin.x -= 5
                        }, completion : { _ in
                            view.becomeFirstResponder()
                        })
                    })
                })
            })
        })
    }
}
