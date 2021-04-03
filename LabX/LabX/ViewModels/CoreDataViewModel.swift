//
//  CoreDataViewModel.swift
//  LabX
//
//  Created by Cristian Zuniga on 3/4/21.
//

import Foundation

class CoreDataViewModel: ObservableObject{
    @Published var coreDM = CoreDataManager()
    @Published var contacts: [ContactEntity] = [ContactEntity]()
    @Published var dollarDebt: Int16 = 0
    @Published var colonesDebt: Int16 = 0
    
    
    func saveContact(name: String){
        //Validations
        coreDM.saveContact(name: name)
    }
    
    func getAllContacts(){
        contacts = self.coreDM.getAllContacts()
        
        dollarDebt = 0
        colonesDebt = 0
        
        contacts.forEach{ contact in
            dollarDebt += contact.deudaDolares
            colonesDebt += contact.deudaColones
        }
    }
  
    func updateContacts(contact: ContactEntity){
        coreDM.updateContacts(contact: contact)
    }
    
    func saveContext(){
        coreDM.saveContext()
    }
    
}
