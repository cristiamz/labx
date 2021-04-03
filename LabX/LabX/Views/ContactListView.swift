//
//  ContactList.swift
//  LabX
//
//  Created by Cristian Zuniga on 3/4/21.
//

import SwiftUI

struct ContactListView: View {
    @ObservedObject var coreDataVM = CoreDataViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                
                Text("Total Balance")
                Text("$\(coreDataVM.dollarDebt)" )
                Text("₡\(coreDataVM.colonesDebt)" )
                
                List {
                    ForEach(coreDataVM.contacts, id: \.self) {
                        contact in
                        NavigationLink(
                            destination: ContactDetailsView(contact: contact),
                            label: {
                                Label(contact.name ?? "No name" , systemImage: "person.icloud")
                            }
                        )
                       Text(debtStatus(contact:contact))
                    }
                }
                
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("My Profile")
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: AddContactView()) {
                        Image(systemName: "square.and.pencil")
                            .imageScale(.large)
                    }
            )
            .onAppear(perform: {
                self.coreDataVM.getAllContacts()
            })
        }
    }
    
    func debtStatus(contact: ContactEntity)->String{
        var debt = ""
        
        if contact.deudaColones > 0 {
            debt += "Owes you ₡\(contact.deudaColones)"
        }else if contact.deudaColones < 0 {
            debt += " You owe ₡\(abs(contact.deudaColones))"
        }else{
            debt += " "
        }
        
        if contact.deudaDolares > 0 {
            debt += "  Owes you $\(contact.deudaDolares)"
        }else if contact.deudaColones < 0 {
            debt += "  You owe $\(abs(contact.deudaDolares))"
        }else{
            debt += ""
        }
        return debt
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}

