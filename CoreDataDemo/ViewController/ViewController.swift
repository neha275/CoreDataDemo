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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var peopleList:[Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nid = UINib(nibName: "PersonTableViewCell", bundle: nil)
        tblPersonList.register(nid, forCellReuseIdentifier: "PersonTableViewCell")
        fetchData()
    }
    
    //MARK: - Get Data From Core Data
    func fetchData() {
        do {
            self.peopleList =  try context.fetch(Person.fetchRequest())
            DispatchQueue.main.async {
                self.tblPersonList.reloadData()
            }
            
        }catch{
            print("Error Occurred \(error.localizedDescription)")
        }
        
    }
    
    //Mark: - For redirection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addperson" {
            let addViewContoller:AddViewController = segue.destination as! AddViewController
            addViewContoller.updateRowDelegate = self
        }
        
    }
    
    
    
    
}

extension ViewController : UpdateRow {
    func updateRow() {
        self.fetchData()
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblPersonList.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
        let person = self.peopleList?[indexPath.row]
        cell.lblName.text = person?.name
        cell.lblAge.text = "\(String(describing: (person?.age)!))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 50
        return UITableView.automaticDimension
    }
    
}

protocol UpdateRow {
    func updateRow()
}
