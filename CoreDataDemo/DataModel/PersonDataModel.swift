//
//  PersonDataModel.swift
//  CoreDataDemo
//
//  Created by Neha Gupta on 01/03/21.
//

import UIKit
import CoreData

class PersonDataModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetachAllData() -> (collection:[Person],status:String,errorMsg:String) {
        let request = Person.fetchRequest() as NSFetchRequest<Person>
        var allPersonData:[Person] = [Person]()
        var errorMsg:String = String()
        var status: String = "Success"
        do {
            allPersonData = try context.fetch(request)
            status = "Success"
        }catch{
            status = "Fail"
            errorMsg = error.localizedDescription
        }
        return(allPersonData, status,errorMsg)
    }
    
    
}
