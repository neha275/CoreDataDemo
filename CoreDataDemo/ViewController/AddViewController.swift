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
        
    }
    

    @IBAction func onCancelButtonTap(_ sender:Any){
        self.dismiss(animated: true, completion: nil)
    }
}
