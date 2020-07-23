//
//  TotalView.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 7/22/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI

struct TotalView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: InvestorGroup.entity(), sortDescriptors:[]) var investorGroup: FetchedResults<InvestorGroup>
    
    private var currentTotal: Double {
        return 1000
    }
    private var groupInvestment: Double {
        return investorGroup.first?.groupInvestment ?? 0
    }
    private var earningsOrLosses: Double {
        return currentTotal - groupInvestment
    }
    private var earningsOrLossesPercentage: Double {
        return (earningsOrLosses / groupInvestment) * 100
    }
    private var sign: String {
        return earningsOrLosses > 0 ? "+" : ""
    }
    
    
    var body: some View {
         ZStack{
            VStack(spacing: 10){
                Text("Total")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .font(.title)
                Text("\(self.currentTotal)")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                           
                Text("Initial Investment")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .font(.title)
                Text("\(self.groupInvestment)")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    
                Text("Earnings/Losses")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .font(.title)
                Text("\(sign)" + "\(self.earningsOrLosses)")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    .foregroundColor(sign.elementsEqual("+") ? Color.green : Color.red)
                
                Text("Earnings/Losses %")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .font(.title)
                Text("\(self.earningsOrLossesPercentage)")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .navigationBarTitle("Add Investor")
        }//.background(self.colorScheme == .dark ? Color.black : Color.white)
    }
}

struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
        TotalView()
    }
}
