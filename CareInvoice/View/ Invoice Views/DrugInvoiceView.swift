//
//  DrugInvoiceView.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import SwiftUI

struct DrugInvoiceView: View {
    
    @State var invoice : DrugInvoiceModel
    @State var hideButton : Bool = false
    let dateFormatter = DateFormatter()
    let currentDate = Date()
    var formattedDate : String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formated = dateFormatter.string(from: currentDate)
        return formated
    }
    
    var body: some View {
        
        VStack (spacing: 10){
            Text("ORGANIZATION NAME")
                .font(.title)
                .padding()
            
            
            HStack {
                Text("Invoice No: \(Int.random(in: 1...1000))")
                Spacer()
                Text("Date: \(formattedDate)")
            }
            .padding(.horizontal)
            
            
            
            
            VStack(alignment: .leading, spacing: 10){
                
                Text("Patient Information")
                    .padding(.top)
                    .font(.title3)
                Divider()
                
                HStack {
                    Text("Patient Name:")
                    Text("\(invoice.patientName)")
                    Spacer()
                }
                .font(.headline)
                
                HStack {
                    Text("Patient Contact:")
                    Text("\(invoice.patientContact)")
                    Spacer()
                }
                .font(.headline)
                
                
                Text("Drug List")
                    .padding(.top)
                    .font(.title3)
                Divider()
                
//                List(invoice.selectedDrugs) { drug in
//                    
//                    Text("\(drug.brandName) - /=")
//                        .listRowInsets(EdgeInsets())
//                        .listRowSeparator(.hidden)
//                        .font(.headline)
//                }
//                .listStyle(.plain)
//                .scrollDisabled(true)
                
                VStack (alignment: .leading, spacing: 10){
                    ForEach(invoice.drugList) { item in
                        Text("\(item.brandName) - \(Int(item.price))/=")
                            .font(.headline)
                    }
                }
                
                Spacer()
                
                
                Text("Total Fee : \(invoice.total) taka")
                    .font(.title)
                
                
                
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Rectangle()
                            .stroke()
                    )
                    .padding()
            
            Button {
                makePDF()
            } label: {
                if hideButton == false {
                    Text("Download PDF")
                }
                
            }
                    
            
            Spacer()
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
