//
//  InvoiceView.swift
//  CareInvoice
//
//  Created by Jotno on 9/25/23.
//

import SwiftUI

struct InvestigationInvoiceView: View {
    
    @State var invoice : InvestigationInvoiceModel
    @State var orgModel : OrganizationModel
    @State var hideButton : Bool = false
    
    @State var showAlert : Bool = false
    
    let dateFormatter = DateFormatter()
    let currentDate = Date()
    var formattedDate : String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formated = dateFormatter.string(from: currentDate)
        return formated
    }
    
    @StateObject var manager = OrganizationManager()
    @AppStorage("OrgID") var OrgID : Int = 0
    @State var orgName = ""
    var body: some View {
        
        
        
        /*
         VStack {
         Text("Invoice")
         .font(.largeTitle)
         VStack(alignment: .leading){
         HStack {
         Text("Patient Name: \(invoice.patientName)")
         }
         HStack {
         Text("Patient Contact:\(invoice.patientContact) ")
         Spacer()
         }
         
         Text("Investigations :")
         .padding(.top)
         .font(.title3)
         
         //                List(invoice.investigation, id: \.self){ invest in
         //
         //                    Text("\(invest.name) - \(invest.fee)")
         //                        .listRowInsets(EdgeInsets())
         //                        .listRowSeparator(.hidden)
         //
         //                }
         //                .listStyle(.plain)
         //                .frame(height: 100)
         
         ForEach(invoice.investigation , id: \.self) { invest in
         Text("\(invest.name)")
         }
         
         Text("Total Fee : \(invoice.totalFee)")
         .padding(.top)
         .font(.title3)
         Spacer()
         
         }
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
         */
        
        /*  Current Design
         
         VStack (spacing: 10){
             
             HStack {
                 
                 Image(systemName: "medical.thermometer")
                     .resizable()
                     .frame(width: 30, height: 30, alignment: .center)
                 
                 Text(manager.orgModel?.name ?? "Organization Name")
                     .font(.title)
                 .padding()
             }
             
             
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
                 
                 
                 Text("Investigation List")
                     .padding(.top)
                     .font(.title3)
                 Divider()
                 
                 //                List(invoice.investigation, id: \.self) { investigation in
                 //
                 //                    Text("\(investigation.name) - \(Int(investigation.fee))/=")
                 //                        .listRowInsets(EdgeInsets())
                 //                        .listRowSeparator(.hidden)
                 //                        .font(.headline)
                 //                }
                 //                .listStyle(.plain)
                 //                .scrollDisabled(true)
                 
                 VStack (alignment: .leading, spacing: 10){
                     ForEach(invoice.investigation, id: \.serviceName) { item in
                         Text("\(item.serviceName) - \(Int(item.serviceCharge))/=")
                             .font(.headline)
                     }
                 }
                 
                 Spacer()
                 
                 Text("Total Fee : \(Int(invoice.totalFee)) taka")
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
         .onAppear{
             DispatchQueue.main.async {
                 manager.getSingleOrganization(from: K.GET_ORGANIZATION_BY_ID, for: OrgID)
             }
         }
         */
        
    
        
        VStack(alignment: .leading, spacing: 20){
            HStack(){
                
                Image(systemName: "pill")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                VStack(alignment: .leading){
                    Text(orgModel.name)
                        .font(.title)
                    Text(orgModel.address)
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
                    Text("\(invoice.p_name)")
                }
                
                HStack {
                    Text("Contact: ")
                    Spacer()
                    Text("\(invoice.contact)")
                }
                
            }
            .font(.system(size: 20))
            .fontWeight(.light)
            .padding()
            
            
            VStack(alignment: .leading, spacing: 20){
                HStack {
                    Text("Investigations: ")
                    Spacer()
                    Text("Amount")
                }
                .font(.title2)
                .fontWeight(.semibold)
                
                Divider()
                
                ForEach(invoice.investigationList, id: \.serviceName) { item in
                    HStack {
                        Text(item.serviceName)
                        Spacer()
                        Text("\(Int(item.serviceCharge))")
                    }
                    .fontWeight(.light)
                }
                .layoutPriority(1)
                
                Divider()
                
               
                
                HStack {
                    Text("Total (Taka) :")
                    Spacer()
                    Text("\(Int(invoice.total))/=")
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
                    showAlert = true
                } label: {
                    if hideButton == false {
                        Text("Download PDF")
                    }
                    
                }
                .alert("Invoice Downloaded", isPresented: $showAlert, actions: {
                    Button("OK", role: .cancel) {
                        
                    }
                })
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
                                        
                                        InvestigationInvoiceView(invoice: invoice, orgModel: orgModel, hideButton: true)
        )
        
        let url = URL.documentsDirectory.appending(path: "investigationInvoice.pdf")
        
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

struct InvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        InvestigationInvoiceView(invoice: InvestigationInvoiceModel(p_name: "Rohid", contact: "01911362438", org_id: 5, investigationList: [InvestigationModel(serviceName: "Dengue", serviceCharge: 100), InvestigationModel(serviceName: "blood", serviceCharge: 200)], total: 300), orgModel: OrganizationModel(name: "org", address: "dhaka", contact: "01911232323", type: "hos", email: "ceo@gmail.com", emergencyContact: "0191123232", operatingHour: "23/3", orgCode: "hos"), hideButton: false)
        // invoice: Invoice(patientName: "Rohid", patientContact: "01911362438", investigation: [Investigation(name: "Dengue", fee: 100), Investigation(name: "blood", fee: 200)], totalFee: 300)
    }
}
