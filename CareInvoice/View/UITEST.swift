//
//  UITEST.swift
//  CareInvoice
//
//  Created by Jotno on 9/17/23.
//

import SwiftUI

struct UITEST: View {
    var body: some View {
        ScrollView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                ListView(listURL: K.Hospitals.GETALLHOSPITAL, title: "Hospital", orgType: K.OrgType.HOSPITAL)
            }//:VSTACK
        }//: Scroll
    }
}


struct UITEST_Previews: PreviewProvider {
    static var previews: some View {
        UITEST()
    }
}
