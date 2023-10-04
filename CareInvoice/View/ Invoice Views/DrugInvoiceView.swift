//
//  DrugInvoiceView.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import SwiftUI

struct DrugInvoiceView: View {
    
    @State var invoice : DrugInvoiceModel
    @StateObject var manager = OrganizationManager()
    @State var hideButton : Bool = false
    let dateFormatter = DateFormatter()
    let currentDate = Date()
    var formattedDate : String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formated = dateFormatter.string(from: currentDate)
        return formated
    }
    
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var body: some View {
        

        
        
        
        VStack(alignment: .leading, spacing: 20){
            HStack(){
                
                Image(systemName: "pill")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                VStack(alignment: .leading){
                    Text(manager.orgModel?.name ?? "Organization Name")
                        .font(.title)
                    Text(manager.orgModel?.type ?? "Organization Type")
                        .font(.subheadline)
                        .fontWeight(.light)
                }
                Spacer()
            }//: HSTACK
            .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: 20){
                HStack {
                    Text("Invoice: ")
                    Spacer()
                    Text("#\(Int.random(in: 1...1000))")
                }
                
                HStack {
                    Text("Date: ")
                    Spacer()
                    Text("\(formattedDate)")
                }
                
                HStack {
                    Text("Patient Name: ")
                    Spacer()
                    Text("\(invoice.patientName)")
                }
                
                HStack {
                    Text("Contact: ")
                    Spacer()
                    Text("\(invoice.patientContact)")
                }
                
            }
            .font(.system(size: 20))
            .fontWeight(.light)
            .padding()
            
            
            VStack(alignment: .leading, spacing: 20){
                HStack {
                    Text("Drugs: ")
                    Spacer()
                    Text("Amount")
                }
                .font(.title2)
                .fontWeight(.semibold)
                
                Divider()
                
                ForEach(invoice.drugList) { item in
                    HStack {
                        Text(item.brandName)
                        Spacer()
                        Text("\(Int(item.price))")
                    }
                    .fontWeight(.light)
                }
                
                
                Divider()
                
               
                
                HStack {
                    Text("Total (Taka) :")
                    Spacer()
                    Text("\(Int(invoice.total))")
                }
                .fontWeight(.medium)
                
                
                
            }
            .font(.system(size: 20))
            .padding()
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    makePDF()
                } label: {
                    if hideButton == false {
                        Text("Download PDF")
                    }
                    
                }
            .padding()
            }
            
            
            Spacer()
        }
        .onAppear{
            DispatchQueue.main.async {
                manager.getSingleOrganization(from: K.GET_ORGANIZATION_BY_ID, for: OrgID)
            }
        }
        
        
        
        
        
    }
    
    @MainActor private func makePDF(){
        let renderer = ImageRenderer(content:
        
            DrugInvoiceView(invoice: invoice, hideButton: true)
        )
        
        let url = URL.documentsDirectory.appending(path: "drugInvoice.pdf")
        
        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            // 5: Create the CGContext for our PDF pages
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }

            // 6: Start a new PDF page
            pdf.beginPDFPage(nil)

            // 7: Render the SwiftUI view data onto the page
            context(pdf)

            // 8: End the page and close the file
            pdf.endPDFPage()
            pdf.closePDF()
            
        }
        print(url.path())
    }
    
}

struct DrugInvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        DrugInvoiceView(invoice: DrugInvoiceModel(patientName: "Rohid", patientContact: "01911362438", orgId: 1, drugList: [DrugModel(id: 1, brandName: "SomeBrand", price: 200.0, vendorName: "SomeVendor", genericName: "SomeGeneric", formationName: "SomeFormation", strengthName: "SomeStength"), DrugModel(id: 2, brandName: "SomeBrand2", price: 200.0, vendorName: "SomeVendor2", genericName: "SomeGeneric2", formationName: "SomeFormation2", strengthName: "SomeStength2")], total: 200), hideButton: false)
    }
}
