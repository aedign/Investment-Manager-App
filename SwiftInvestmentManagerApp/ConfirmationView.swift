//
//  ConfirmationView.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 6/2/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI

struct ConfirmationView: View {
    
    private let investorName:String
    private let investorInitialInvestment:String
    
    init(investor:Investor){
        self.investorName = investor.name! + " was added"
        self.investorInitialInvestment = String(investor.initialInvestment)
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 10){
                Text(self.investorName)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                Text("Name")
                Text("Initial Investment")
                Text("Stake")
                Text("Investor Group")
                Text("")
                Spacer()
            }  .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                          .frame(height: geometry.size.height )
        }.padding()
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(investor:Investor())
    }
}
