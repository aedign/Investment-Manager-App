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
    
    public init(name: String, currentStakePercentage: Float, currentTotal: Double){
        self.investorName = name
        self.investorCurrentStakePercentage = currentStakePercentage
        self.investorCurrentTotal = currentTotal
    }
    
    var body: some View{
        GeometryReader{ geometry in
                HStack{
                    Text(self.investorName!).fontWeight(.bold)
                        .frame(width: geometry.size.width / 2.4, height: geometry.size.height - 10, alignment: .leading)
                        
                    Text(String(format: "%.2f", self.investorCurrentStakePercentage!) + "%")
                        .frame(width: geometry.size.width / 5, height: geometry.size.height - 10, alignment: .leading)
                    Text(String(format: "%.2f", self.investorCurrentTotal!) + "$")
                        .frame(width: geometry.size.width / 3, height: geometry.size.height - 10, alignment: .leading)
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
        InvestorListView(name: "Andres Di Gregorio", currentStakePercentage: 100.00, currentTotal: 12000.0)
    }
}
#endif
