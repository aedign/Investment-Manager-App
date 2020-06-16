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
    
    var body: some View {
         TabView(selection: $initialTab){
                InvestorsView()
                    .tabItem{
                        Image(systemName: "person.fill")
                        Text("Investors")
                }
                .tag(0)
            Text("Total")
                    .tabItem{
                        Image(systemName: "dollarsign.circle.fill")
                        Text("Total")
                }
                .tag(1)
                Text("Hypotheticals")
                    .tabItem{
                        Text("Hypoteticals")
                        Image(systemName: "percent")
                }
                .tag(2)
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
