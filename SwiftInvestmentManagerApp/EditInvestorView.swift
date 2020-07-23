//
//  ConfirmationView.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 6/2/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI

struct EditInvestorView: View {
    
    @ObservedObject var inv:Investor
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var next:Bool = false
    
    var body: some View {
        NavigationView{
        ZStack{
            VStack(alignment: .leading, spacing: 20){
                Group{
                    Text(self.inv.name).font(.largeTitle).bold()
                    Spacer().frame(height: 0)
                    Text("Initial Investment").font(.title).fontWeight(.bold)
                    Text(String(self.inv.initialInvestment) + "$").font(.title)
                    Text("Current Total").font(.title).fontWeight(.bold)
                    Text(String(self.inv.currentTotal) + "$").font(.title)
                    Text("Current Earnings").font(.title).fontWeight(.bold)
                    Text(String(self.inv.earningsAmount) + "$").font(.title)
                }
                Group{
                    Text("Current Earnings %").font(.title).fontWeight(.bold)
                    Text(String(self.inv.earningsPercentage) + "%").font(.title)
                    Text("Stake %").font(.title).fontWeight(.bold)
                    Text(String(self.inv.currentStakePercentage) + "%").font(.title)
                }
                Spacer()
                
                NavigationLink("Button", destination: InvestorHistory(investor: inv).environment(\.managedObjectContext, self.managedObjectContext))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
    }
}


struct EditInvestorView_Previews: PreviewProvider {
    static var previews: some View {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let inv = Investor(context: managedObjectContext)
        inv.name = "Andres Di Gregorio"
        inv.initialInvestment = 1000
        inv.currentTotal = 1200
        inv.earningsAmount = inv.currentTotal - inv.initialInvestment
        inv.earningsPercentage = Float(inv.earningsAmount / inv.initialInvestment) * 100
        inv.currentStakePercentage = 80.0
        return EditInvestorView(inv: inv)
    }
}
