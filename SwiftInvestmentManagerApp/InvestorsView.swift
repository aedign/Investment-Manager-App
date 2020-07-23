//
//  ContentView.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 4/2/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI
import CoreData

struct InvestorsView: View {
    
    @State var isPressed = false
    @State private var addInvestorButtonPressed = false
    @State private var showAddInvestorView = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Investor.entity(), sortDescriptors:[NSSortDescriptor(key: "name", ascending: true)]) var investorList: FetchedResults<Investor>
    @FetchRequest(entity: InvestorGroup.entity(), sortDescriptors:[]) var investorGroup: FetchedResults<InvestorGroup>
    
    var body: some View {
        ZStack{
            NavigationView{
                    GeometryReader{ geometry in
                        List{
                            if(self.investorList.count == 0){
                                    Text("There are no Investors")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .foregroundColor(.gray)
                            }
                            else{
                                ForEach(self.investorGroup, id: \.self) {group in
                                    ForEach(self.investorList, id: \.self){ investor in
                                        InvestorListView(investor: investor)
                                            .onTapGesture {self.isPressed.toggle()}
                                            .sheet(isPresented: self.$isPressed){EditInvestorView(inv: investor).environment(\.managedObjectContext, self.managedObjectContext)}
                                    } .onDelete(perform: self.deleteInvestor)
                                }
                            }
                           
                        }
                        .environment(\.defaultMinListRowHeight, geometry.size.height / 7)
                        .onAppear{ UITableView.appearance().separatorStyle = .none }
                    }
                    .navigationBarTitle("Investors")
                    .navigationBarItems(trailing:
                        NavigationLink(destination: AddInvestorView().environment(\.managedObjectContext, self.managedObjectContext)){
                            Image(systemName: "person.badge.plus.fill")
                                .font(.largeTitle)
                        }
                        .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                    )
            }
        }
    }
    
    private func deleteInvestor(indexSet: IndexSet){
        
        let source = indexSet.first!
        let investorToDelete = investorList[source]
        let group = investorGroup.first!
        group.groupInvestment -= investorToDelete.initialInvestment
        managedObjectContext.delete(investorToDelete)

        if group.hasMany?.count == 1 {managedObjectContext.delete(group)}
        else{
            print("AAAAAAAAAAAAAAAAAAAA")
            for investor in investorList{
                investor.currentStakePercentage = Float((investor.initialInvestment / (group.groupInvestment)) * 100)
            }
        }
        save()
    }
          
    private func save(){
        do{
            try managedObjectContext.save()
        }
        catch{
            print("Error while saving")
        }
    }
}

#if DEBUG
struct InvestorsView_Previews: PreviewProvider {
    static var previews: some View {
        InvestorsView()
    }
}
#endif
