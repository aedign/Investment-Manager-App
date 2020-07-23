//
//  InvestorHistory.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 7/22/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import CoreData
import SwiftUI

struct InvestorHistory: View {
    
    private let investor:Investor
    private let array:[InvestorChange]
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    public init(investor: Investor){
        self.investor = investor
        self.array = investor.makes.allObjects as! [InvestorChange]
    }
    
    var body: some View {
        ZStack{
            NavigationView{
                    GeometryReader{ geometry in
                        List{
                            ForEach(self.array, id: \.self){ change in
                                InvestorChangeList(change: change)
                            }
                    }
                        .environment(\.defaultMinListRowHeight, geometry.size.height / 7)
                        .onAppear{ UITableView.appearance().separatorStyle = .none }
                    }
                    .navigationBarTitle("History")
                        //.foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
            }
        }
    }
}

struct InvestorHistory_Previews: PreviewProvider {
    static var previews: some View {
        let b = Investor()
        b.name = "e"
        return InvestorHistory(investor: b)
    }
}
