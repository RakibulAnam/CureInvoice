//
//  FormTextFieldView.swift
//  CareInvoice
//
//  Created by Jotno on 9/17/23.
//

import SwiftUI

struct FormTextFieldView: View {
    
    @State private var text: String = ""
    @State var title : String
    @Binding var bindingText : String
    @State var isValid : Bool = true
   @State  var validate : ((String)->Bool)?
    var body: some View {
        
        VStack(alignment: .leading , spacing: 5){
            Text(title)
                .font(.title3)
                .fontWeight(.light)
            TextField("", text: $bindingText)
                .onChange(of: bindingText, perform: { newValue in
                    if validate != nil {
                        isValid = validate!(newValue)
                    }
                })
                .padding()
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled(true)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color("PrimaryColor"), lineWidth: 2)) // Apply a rounded border
            
            if !isValid {
                        Text("Please enter a valid \(title).")
                            .foregroundColor(.red)
                            
                    }
        }//:Vstack
        .padding(2)
        
    }
}

struct FormTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        FormTextFieldView(title: "Name", bindingText: .constant("rakibul"), validate: { _ in
            return false
        })
            .previewLayout(.sizeThatFits)
    }
}


