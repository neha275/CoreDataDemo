//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Neha Gupta on 26/02/21.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var tblPersonList:UITableView!
    
    //let context = (UIApplication.shared.delegate as! UIApplication).per.viewContext
    var peopleList:[Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nid = UINib(nibName: "PersonTableViewCell", bundle: nil)
        tblPersonList.register(nid, forCellReuseIdentifier: "PersonTableViewCell")
        
    }
    
    func fecthData() {
        
    }
    
    
}


extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblPersonList.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 50
        return UITableView.automaticDimension
    }
}
/*
 */
