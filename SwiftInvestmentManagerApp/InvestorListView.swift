//
//  InvestorListView.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 4/6/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI
import CoreData

struct InvestorListView : View{
    
    private var investorName:String?
    private var investorCurrentStakePercentage:Float?
    private var investorCurrentTotal:Double?
    @Environment(\.colorScheme) var colorScheme
    
    public init(name: String, currentStakePercentage: Float, currentTotal: Double){
        self.investorName = name
        self.investorCurrentStakePercentage = currentStakePercentage
        self.investorCurrentTotal = currentTotal
    }
    
    var body: some View{
        ZStack{
            HStack{
               // Spacer().frame(width: 0)
                Text(self.investorName!).font(.system(size: 18)).fontWeight(.bold)
                Spacer().frame(width: 18)
                Text(String(format: "%.2f", self.investorCurrentStakePercentage!) + "%")
                Spacer().frame(width: 18)
                Text(String(format: "%.2f", self.investorCurrentTotal!) + "$")
            }.font(.system(size: 18)).font(.system(.body, design: .rounded))
        }
            .foregroundColor(.white)
            .frame(width: 380, height: 75.0)
            .background(Color.blue)
            .contentShape(RoundedRectangle(cornerRadius: 17.0))
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .shadow(radius: 4.5)
    }
}

#if DEBUG
struct InvestorListView_Previews: PreviewProvider {
    static var previews: some View {
        InvestorListView(name: "A", currentStakePercentage: 12.0, currentTotal: 12.0)
    }
}
#endif
