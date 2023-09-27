//
//  InvoiceView.swift
//  CareInvoice
//
//  Created by Jotno on 9/25/23.
//

import SwiftUI

struct AppointmentInvoiceView: View {
    
   @State var invoice : Invoice
    @State var hideButton : Bool
   // @StateObject var invoiceViewModel = InvoiceViewModel()
    var body: some View {
        

        
        
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
        
        
        
    }
    
    @MainActor
    private func exportPDF() {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let renderedUrl = documentDirectory.appending(path: "invoice.pdf")
        
        if let consumer = CGDataConsumer(url: renderedUrl as CFURL),
           let pdfContext = CGContext(consumer: consumer, mediaBox: nil, nil) {
            
            let renderer = ImageRenderer(content: AppointmentInvoiceView(invoice: invoice, hideButton: true))
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
        
                                        AppointmentInvoiceView(invoice: invoice, hideButton: true)
        )
        
        let url = URL.documentsDirectory.appending(path: "output.pdf")
        
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
        AppointmentInvoiceView(invoice: Invoice(patientName: "Rohid", patientContact: "01911362438", investigation: [Investigation(name: "Dengue", fee: 100), Investigation(name: "blood", fee: 200)], totalFee: 300), hideButton: false)
   // invoice: Invoice(patientName: "Rohid", patientContact: "01911362438", investigation: [Investigation(name: "Dengue", fee: 100), Investigation(name: "blood", fee: 200)], totalFee: 300)
    }
}
