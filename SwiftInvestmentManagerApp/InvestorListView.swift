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
        GeometryReader{ geometry in
                HStack{
                    Text(self.investorName!).fontWeight(.bold).frame(width: geometry.size.width / 2.19, height: geometry.size.height - 10, alignment: .leading)
                    Spacer()
                    Text(String(format: "%.2f", self.investorCurrentStakePercentage!) + "%")
                    Text(String(format: "%.2f", self.investorCurrentTotal!) + "$")            
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .frame(height: geometry.size.height )
                .font(.system(size: geometry.size.width / 20))
                .font(.system(.body, design: .rounded))
                .foregroundColor(.white)
                .background(Color.blue)
               // .contentShape(RoundedRectangle(cornerRadius: 20.0))
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .shadow(radius: 4.5)
        }//.frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 12)
    }

}

#if DEBUG
struct InvestorListView_Previews: PreviewProvider {
    static var previews: some View {
        InvestorListView(name: "Andres Di Gregorio", currentStakePercentage: 12.0, currentTotal: 1200.0)
    }
}
#endif
