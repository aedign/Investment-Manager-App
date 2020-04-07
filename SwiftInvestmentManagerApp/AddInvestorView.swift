//
//  AddInvestorView.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 4/4/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI

struct AddInvestorView: View {
    
     @Environment(\.colorScheme) var colorScheme
     @State private var name:String = ""
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            NavigationView{
                VStack(alignment: .leading, spacing: 40){
                    HStack{
                        Text("Name:")
                            .fontWeight(.bold)
                            .frame(width: 70, height: 60.0, alignment: .leading)
                            .font(.system(size: 22)).font(.system(.body, design: .rounded))
                            .foregroundColor(Color.white)
   
                        TextField("", text: $name)
                            .padding()
                            .frame(width: 285, height: 55.0, alignment: .leading)
                            .font(.system(size: 18)).font(.system(.body, design: .rounded))
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
        
                    }
                    .padding()
                    .frame(width: 380, height: 60.0, alignment: .leading)
                    .font(.system(size: 18)).font(.system(.body, design: .rounded))
                    .background(Color.gray)
                    .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                  //  .contentShape(RoundedRectangle(cornerRadius: 17.0))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 4.0))
                    
                    
                    HStack{
                        Text("E")
                    }
                    HStack{
                        Text("EEEE")
                    }
                    
                    Spacer()
                }.navigationBarTitle("Add Investor")
            }
        }
    }
}

struct AddInvestorView_Previews: PreviewProvider {
    static var previews: some View {
        AddInvestorView()
    }
}
