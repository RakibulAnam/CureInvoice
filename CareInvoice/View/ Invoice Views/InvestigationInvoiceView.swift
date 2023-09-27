//
//  InvoiceView.swift
//  CareInvoice
//
//  Created by Jotno on 9/25/23.
//

import SwiftUI

struct InvestigationInvoiceView: View {
    
    @State var invoice : InvestigationInvoiceModel
    @State var hideButton : Bool
    let dateFormatter = DateFormatter()
    let currentDate = Date()
    var formattedDate : String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formated = dateFormatter.string(from: currentDate)
        return formated
    }
    
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
                    ForEach(invoice.investigation, id: \.self) { item in
                        Text("\(item.name) - \(Int(item.fee))/=")
                            .font(.headline)
                    }
                }
                
                Spacer()
                
                Text("Total Fee : \(invoice.totalFee) taka")
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
    
    @MainActor
    private func exportPDF() {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let renderedUrl = documentDirectory.appending(path: "invoice.pdf")
        
        if let consumer = CGDataConsumer(url: renderedUrl as CFURL),
           let pdfContext = CGContext(consumer: consumer, mediaBox: nil, nil) {
            
            let renderer = ImageRenderer(content: InvestigationInvoiceView(invoice: invoice, hideButton: true))
            renderer.render { size, renderer in
                let options: [CFString: Any] = [
                    kCGPDFContextMediaBox: CGRect(origin: .zero, size: size)
                ]
                
                pdfContext.beginPDFPage(options as CFDictionary)
                
                renderer(pdfContext)
                pdfContext.endPDFPage()
                pdfContext.closePDF()
            }
        }
        
        print("Saving PDF to \(renderedUrl.path())")
    }
    
    
    @MainActor private func makePDF(){
        let renderer = ImageRenderer(content:
                                        
                                        InvestigationInvoiceView(invoice: invoice, hideButton: true)
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
        InvestigationInvoiceView(invoice: InvestigationInvoiceModel(patientName: "Rohid", patientContact: "01911362438", investigation: [Investigation(name: "Dengue", fee: 100), Investigation(name: "blood", fee: 200)], totalFee: 300), hideButton: false)
        // invoice: Invoice(patientName: "Rohid", patientContact: "01911362438", investigation: [Investigation(name: "Dengue", fee: 100), Investigation(name: "blood", fee: 200)], totalFee: 300)
    }
}
