//
//  AddViewController.swift
//  CoreDataDemo
//
//  Created by Neha Gupta on 27/02/21.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    var updateRowDelegate:UpdateRow?
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:  #selector(self.viewTapGesture(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Gesture -
    @objc func viewTapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onAddbuttonTap(_ sender:Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let newPeople = Person(context: context)
        newPeople.name = txtName.text
        newPeople.age = Int64(txtAge.text!) ?? 18
        //Save Data
        do {
                try context.save()
        }catch {
            print(" Unable to save data \(error.localizedDescription)")
        }
        
        self.dismiss(animated: true, completion: { () -> Void in
            self.updateRowDelegate?.updateRow()
        })
        
    }
    

    @IBAction func onCancelButtonTap(_ sender:Any){
        self.dismiss(animated: true, completion: nil)
    }
}


