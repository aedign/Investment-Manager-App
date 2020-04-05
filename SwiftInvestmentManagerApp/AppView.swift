//
//  AppView.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 4/3/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
         TabView{
                InvestorsView()
                    .tabItem{
                        Image(systemName: "person.fill")
                        Text("Investors")
                }
                AddInvestorView()
                    .tabItem{
                        Image(systemName: "dollarsign.circle.fill")
                        Text("Total")
                }
                Text("Hypotheticals")
                    .tabItem{
                        Text("Hypoteticals")
                        Image(systemName: "percent")
                }
         }.tag(0)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
