//
//  AppointmentInvoiceView.swift
//  CareInvoice
//
//  Created by Jotno on 10/2/23.
//

import SwiftUI

struct AppointmentInvoiceView: View {
    
    
    @State var invoice : AppointmentInvoiceModel
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
                
                HStack {
                    Text("Doctor: ")
                    Spacer()
                    Text("\(invoice.doc_name)")
                }
                
                HStack {
                    Text("Slot: ")
                    Spacer()
                    Text("\(invoice.slot)")
                }
                
            }
            .font(.system(size: 20))
            .fontWeight(.light)
            .padding()
            
            
            VStack(alignment: .leading, spacing: 20){
                HStack {
                    Text("Fees ")
                    Spacer()
                    
                }
                .font(.title2)
                .fontWeight(.semibold)
                
                Divider()
                
                HStack {
                    Text("Consultaion: ")
                    Spacer()
                    Text("\(invoice.consultationFee)")
                }
                
                HStack {
                    Text("Discount: ")
                    Spacer()
                    Text("\(invoice.discount)")
                }
                
                
                Divider()
                
               
                
                HStack {
                    Text("Total (Taka) :")
                    Spacer()
                    Text("\(Int(invoice.totalFees))")
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
        
            AppointmentInvoiceView(invoice: invoice)
        )
        
        let url = URL.documentsDirectory.appending(path: "appointmentInvoice.pdf")
        
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

struct AppointmentInvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentInvoiceView(invoice: AppointmentInvoiceModel(patientName: "MAruf", orgId: 1, patientContact: "01232323", doc_name: "BroDOC", doc_id: 1, slot: "mornig-tuesday", consultationFee: "100", discount: "100", totalFees: 500.0))
    }
}
