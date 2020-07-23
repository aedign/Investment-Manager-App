//
//  AppView.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 4/3/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    @State private var initialTab = 1
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
         TabView(selection: $initialTab){
                InvestorsView()
                    .tabItem{
                        Image(systemName: "person.fill")
                        Text("Investors")
                }
                .tag(0)
            TotalView().environment(\.managedObjectContext, self.managedObjectContext)
                    .tabItem{
                        Image(systemName: "dollarsign.circle.fill")
                        Text("Total")
                }
                .tag(1)
         }
    }
}

#if DEBUG
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
#endif
