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
        let objPersonDataModel = PersonDataModel()
        let data = objPersonDataModel.fetachAllData()
        if data.status == "Success" {
            self.peopleList =  data.collection
            DispatchQueue.main.async {
                self.tblPersonList.reloadData()
            }
        }else {
            print("Error Occurred \(data.errorMsg)")
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
    
    //MARK: Edit Option
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.peopleList![indexPath.row]
        //Create Alert To edit
        let alert = UIAlertController(title: "Edit", message: "Edit Name", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        let txtName = alert.textFields![0]
        txtName.text = person.name
        let txtAge = alert.textFields![1]
        txtAge.text = "\(person.age)"
        
        //Configure Button
        let saveButton = UIAlertAction(title: "Save", style: .default, handler: {
            (action) in
            
            person.name = alert.textFields![0].text
            //let age  = alert.textFields![1].text
            person.age = Int64(alert.textFields![1].text!) ?? 18
            do {
                try self.context.save()
            }catch{
                print("Error occurred while editing \(error.localizedDescription)")
            }
            self.fetchData()
            
        })
        alert.addAction(saveButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Swipe Option for Delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: {
            (sction, view, completionHandler) in
        
            
            let alertView = UIAlertController(title: "", message: "Are you sure you want to delete ? ", preferredStyle: .alert)
                     let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        let personToRemove = self.peopleList![indexPath.row]
                        self.context.delete(personToRemove)
                        do {
                            try self.context.save()
                        }catch {
                            print("Error occurred in \(error.localizedDescription)")
                        }
                        self.fetchData()
                        
                    })
                    let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: { (alert) in
                        //Disable the Action
                        self.fetchData()
                    })
                    alertView.addAction(okAction)
                    alertView.addAction(cancelAction)
                    self.present(alertView, animated: true, completion: nil)
        })
        action.image =  UIImage(systemName: "xmark.bin")
        
        return  UISwipeActionsConfiguration(actions: [action])
    }
}

protocol UpdateRow {
    func updateRow()
}
