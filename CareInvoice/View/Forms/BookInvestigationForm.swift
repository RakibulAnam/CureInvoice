////
////  BookInvestigationForm.swift
////  CareInvoice
////
////  Created by Jotno on 9/25/23.
////
//
//import SwiftUI
//
//struct BookInvestigationForm: View {
//    
//    var investigations : [InvestigationModel] = [InvestigationModel(serviceName: "Blood Test", serviceCharge: 1000), InvestigationModel(serviceName: "Dengue Tes", serviceCharge: 1200)]
//    @StateObject var invoiceViewModel = InvoiceViewModel()
//   // @State var selectedItem : Investigation?
//    @State var multiSelect = Set<InvestigationModel>()
//    @State var invoiceGenerated : Bool = false
//     var selectedInvestigation : [InvestigationModel] {
//        var selected : [InvestigationModel] = []
//         
//         multiSelect.forEach { Investigation in
//             selected.append(Investigation)
//         }
//         
//         return selected
//    }
//    var totalFee : Int {
//        var total = 0
//        multiSelect.forEach { Investigation in
//            total = total + Investigation.serviceCharge
//        }
//        return total
//    }
//    @State var name = ""
//    
//    @State var contact = ""
//    //@Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        
//        
//            ZStack {
//                
//                    VStack(alignment: .leading){
//                        
//                        Text("Book Investigation")
//                            .font(.title)
//                        
//
//                            FormTextFieldView(title: "Patient Name", bindingText: $name)
//                            
//                            FormTextFieldView(title: "Patient Contact", bindingText: $contact, validate: isValidContact)
//                        
//                        Text("Select Investigation")
//                            .font(.title)
//                            .padding(.top)
//                        
//                        List(investigations, id: \.self,  selection: $multiSelect){ items in
//                            
//                            Text("\(items.serviceName) - \(items.serviceCharge)")
//                            
//                        }
//                        .environment(\.editMode, .constant(.active))
//                        .listStyle(.plain)
//                        
//                        
//                        HStack{
//                            Text("Total Taka: \(totalFee)")
//                        }
//                        .font(.title2)
//                        
//                       
//                       
//                     /*
//                        Button {
//                            /*
//                            let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
//                            
//                            manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
//                             
//                            */
//                            
//                            invoiceViewModel.invoice = Invoice(patientName: name, patientContact: contact, investigation: selectedInvestigation, totalFee: totalFee)
//                            
//                            print(invoiceViewModel.invoice!)
//                            
//                            
//                          
//                            
//                        } label: {
//                            Text("Add".uppercased())
//                                .font(.title2)
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
//                                .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
//                                .background(Color("PrimaryColor"))
//                                .cornerRadius(10)
//                                .padding(.vertical)
//                            
//                        }
//                        */
//                       
//                        NavigationLink(destination: InvestigationInvoiceView(invoice: InvestigationInvoiceModel(patientName: name, patientContact: contact, investigation: selectedInvestigation, totalFee: totalFee), hideButton: false), isActive: $invoiceGenerated) {
//                            Button {
////                                /*
////                                let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
////
////                                manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
////
////                                */
////
////                                invoiceViewModel.setInvoice(name: name, contact: contact, selectedInvestigation: selectedInvestigation, totalFee: totalFee)
////
////                                print(invoiceViewModel.invoice!)
//                                
//                                invoiceGenerated = true
//                                
//                              
//                                
//                            } label: {
//                                Text("Add".uppercased())
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.white)
//                                    .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
//                                    .background(Color("PrimaryColor"))
//                                    .cornerRadius(10)
//                                    .padding(.vertical)
//                                
//                            }
//                        }
//
//                        
//                        
//                       
//                            
//                      
//                            
//                     
//                        Spacer()
//                    } //: VSTACK
//                    .padding()
//                    .background(Color.white)
//                .cornerRadius(20)
//                
//                
//                
//                
//            }
//        //: ZSTACK
//    }
//    
//    func isValidContact(_ contact: String) -> Bool {
//        let contactRegex = #"^(?:\+88|01)?\d{11}$"#
//        let contactPredicate = NSPredicate(format: "SELF MATCHES %@", contactRegex)
//        return contactPredicate.evaluate(with: contact)
//    }
//}
//
//
//
//
//
//struct BookInvestigationForm_Previews: PreviewProvider {
//    static var previews: some View {
//        BookInvestigationForm()
//    }
//}
