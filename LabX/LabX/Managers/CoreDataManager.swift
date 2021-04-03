//
//  CoreDataManager.swift
//  LabX
//
//  Created by Cristian Zuniga on 3/4/21.
//

import Foundation
import CoreData

class CoreDataManager{
    
    let persistentContainer: NSPersistentContainer
    
    init(){
        // Which files should the container use.
        persistentContainer = NSPersistentContainer(name: "LabXDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print("Unable to load Core Data Store \(error)")
            }
        }
    }
    
    func saveContact(name: String){
        let contact = ContactEntity(context: persistentContainer.viewContext)
        contact.name = name
  
        if (try? persistentContainer.viewContext.save()) != nil{
            print("Success to save")
        }else{
            print("Failed to save")
        }
    }
    
    func saveContext(){
        if (try? persistentContainer.viewContext.save()) != nil{
            print("Success to save")
        }else{
            print("Failed to save")
        }
    }
    
    func updateContacts(contact: ContactEntity){
       
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        fetchRequest.predicate =  NSPredicate(format: "name == %@", contact.name ?? "")
        
        if let result = try? persistentContainer.viewContext.fetch(fetchRequest){
            
            let objectToUpdate = result[0]
            objectToUpdate.deudaColones = contact.deudaColones
            objectToUpdate.deudaDolares = contact.deudaDolares
            
            if (try? persistentContainer.viewContext.save()) != nil{
                print("Success to update")
            }else{
                print("Failed to update")
            }
        }
       
        
        
    }
    
    func getAllContacts() -> [ContactEntity] {
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        
        if let result = try? persistentContainer.viewContext.fetch(fetchRequest){
            print("Success to retrieve all contacts")
            return result
        }
        print("Failed to retrieve all contacts")
        return []

    }
//    
//    func deleteTask(task: TaskEntity){
//        // Mark for deletion
//        persistentContainer.viewContext.delete(task)
//        
//        if let result = try? persistentContainer.viewContext.save(){
//            print("Success to delete task")
//        }else{
//            persistentContainer.viewContext.rollback()
//            print("Failed to delete task")
//        }
//        
//    }
    
    
}
