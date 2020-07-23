//
//  InvestorChangeList.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 7/22/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI

struct InvestorChangeList: View {
    
    private let change:InvestorChange
    
    public init(change: InvestorChange){
        self.change = change
    }
    
    var body: some View {
        GeometryReader{ geometry in
                HStack{
                    Text("\(self.change.moneyAdded)")
                        .fontWeight(.bold)
                        .frame(width: geometry.size.width / 2.4, height: geometry.size.height - 10, alignment: .leading)
                        
                    Text("\(self.change.date)")
                        .frame(width: geometry.size.width / 5, height: geometry.size.height - 10, alignment: .leading)
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
        }
    }
}

struct InvestorChangeList_Previews: PreviewProvider {
    static var previews: some View {
        let a = InvestorChange()
        a.date = Date()
        a.moneyAdded = 2500
        return InvestorChangeList(change: a)
    }
}
