//
//  ContactDetailsView.swift
//  LabX
//
//  Created by Cristian Zuniga on 3/4/21.
//

import SwiftUI

struct ContactDetailsView: View {
    let contact: ContactEntity
    
    @State var debeDolares: String = ""
    @State var debeColones: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var coreDataVM = CoreDataViewModel()
    
   
    var body: some View {
        //NavigationView{
        VStack {
            Form{
                Text(contact.name ?? "No Name")
                Text("Total Balance $\(contact.deudaDolares)" )
                Text("Total Balance ₡\(contact.deudaColones)" )
                
                
                Text("Agregar deuda en dolares")
                TextField("\(abs(contact.deudaColones))", text: $debeDolares)
                Text("Agregar deuda en colones")
                TextField("\(abs(contact.deudaDolares))", text: $debeColones)
            }
            Button(action: Save) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Modificar deudas")
                }
            }
            .foregroundColor(Color.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(15.0)
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Deudas").font(.headline)
                }
            }
        }
    }
        func Save(){
            contact.deudaColones += Int16(debeColones) ?? 0
            contact.deudaDolares += Int16(debeDolares) ?? 0
            self.coreDataVM.updateContacts(contact: contact)
            self.presentationMode.wrappedValue.dismiss()
        }
}

struct ContactDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let Contact = ContactEntity()
        ContactDetailsView(contact: Contact)
    }
}
