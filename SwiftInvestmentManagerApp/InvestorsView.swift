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

    @State private var addInvestorButtonPressed = false
    @State private var showAddInvestorView = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Investor.entity(), sortDescriptors:[NSSortDescriptor(key: "name", ascending: true)]) var investorList: FetchedResults<Investor>
    @FetchRequest(entity: InvestorGroup.entity(), sortDescriptors:[]) var investorGroup: FetchedResults<InvestorGroup>
    
    var body: some View {
        
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            NavigationView{
                VStack{
                    GeometryReader{ geometry in
                        List{
                            if(self.investorList.count == 0){
                                    Text("There are no Investors")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .foregroundColor(.gray)
                            }
                            else{
                                ForEach(self.investorList, id: \.self){ investor in
                                    InvestorListView(name: investor.name!, currentStakePercentage: investor.currentStakePercentage, currentTotal: investor.currentTotal)
                                } .onDelete(perform: self.deleteInvestor)
                            }
                           
                        }
                        .environment(\.defaultMinListRowHeight, geometry.size.height / 7)
                        .onAppear{ UITableView.appearance().separatorStyle = .none }
                    }
                    .navigationBarTitle("Investors")
                    .navigationBarItems(trailing:
                    HStack {
                        Button(action: {
                            self.addInvestor()
                            self.showAddInvestorView.toggle()
                        })
                        {
                            Image(systemName: "person.badge.plus.fill")
                                .font(.largeTitle)
                        }
                        .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                    })
                    .sheet(isPresented: self.$showAddInvestorView){
                        AddInvestorView().environment(\.managedObjectContext, self.managedObjectContext)
                    }
                
                    HStack(alignment: .center){
                        Button("Add Investor"){
                    }
                  //  .simultaneousGesture(LongPressGesture(minimumDuration: 2, maximumDistance: 1).onEnded{_ in
                       // self.addInvestorGroup()
                   // })
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    .scaleEffect(self.addInvestorButtonPressed ? 1.2 : 1.0)
                        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: {
                        pressing in
                        withAnimation(.easeInOut(duration: 0.6)){
                            self.addInvestorButtonPressed = pressing
                            }
                        }, perform :{})
                    .padding()
                    }
                }
            }
        }
    }
    
    private func addInvestorGroup(){
        let newInvestorGroup = InvestorGroup(context: managedObjectContext)
        newInvestorGroup.initialInvestment = 3000.0
        newInvestorGroup.lastChangeDate = Date()
        save()
    }
    
    
    private func deleteInvestor(indexSet: IndexSet){
        let source = indexSet.first!
        let investorToDelete = investorList[source]
        managedObjectContext.delete(investorToDelete)
        save()
     }
    
    private func deleteInvestorGroup(indexSet: IndexSet){
       let source = indexSet.first!
       let investorGroupToDelete = investorGroup[source]
       managedObjectContext.delete(investorGroupToDelete)
       save()
    }
     
    private func addInvestor(){
         
        let newInvestor = Investor(context: managedObjectContext)
        newInvestor.name = "Andres Di Gregorio"
        newInvestor.currentStakePercentage = 13.0
        newInvestor.currentTotal = 1400.0
        
        
        let investorChange = InvestorChange(context: managedObjectContext)
               investorChange.date = Date()

      //  newInvestor.addToChange(investorChange)

        
        save()
        /*
        // use this to refer to the class when creating it
        let investorClassName:String = String(describing: Investor.self)
        */
     }
    
    private func save(){
        do{
            try managedObjectContext.save()
        }
        catch{
            print("Error saving")
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
