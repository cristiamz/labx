//
//  AddContactView.swift
//  LabX
//
//  Created by Cristian Zuniga on 3/4/21.
//

import SwiftUI

struct AddContactView: View {
    @State var contactName: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var coreDataVM = CoreDataViewModel()
    
   
    var body: some View {
        //NavigationView{
        VStack {
            Form{
                Text("Contact Name")
                TextField("Contact ...", text: $contactName)
            }
            Button(action: Save) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                    
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
                    Text("Add Contact").font(.headline)
                }
            }
        }
        
        
    }
    func Save(){
        self.coreDataVM.saveContact(name: contactName)
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
