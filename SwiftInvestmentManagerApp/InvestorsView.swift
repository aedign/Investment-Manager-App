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
    @State private var addButtonColor = Color.blue
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Investor.entity(), sortDescriptors:[NSSortDescriptor(key: "name", ascending: true)]) var investorList: FetchedResults<Investor>
    @FetchRequest(entity: InvestorGroup.entity(), sortDescriptors:[]) var investorGroup: FetchedResults<InvestorGroup>
    
    var body: some View {
        
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            NavigationView{
                VStack{
                    List{
                        ForEach(investorList, id: \.self){ investor in
                            InvestorListItem(name: investor.name!, currentStakePercentage: investor.currentStakePercentage, currentTotal: investor.currentTotal)
                        }.onDelete(perform: deleteInvestor)
                        }
                    .navigationBarTitle("Investors")
                    .navigationBarItems(trailing:
                        HStack {
                            Button(action: {
                                self.addInvestor()
                                self.showAddInvestorView.toggle()
                            }) {
                                Image(systemName: "person.badge.plus.fill")
                                    .font(.largeTitle)
                            }
                            .foregroundColor(Color.white)
                        })
                            .sheet(isPresented: self.$showAddInvestorView){
                                AddInvestorView()
                            }
                
                HStack(alignment: .center){
                    Button("Add Investor"){
                    }
                    .simultaneousGesture(LongPressGesture(minimumDuration: 2, maximumDistance: 1).onEnded{_ in
                        self.addInvestorGroup()
                    })
                    
                    .padding()
                    .frame(alignment: .center)
                    .background(addButtonColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(addButtonColor, lineWidth: 5))
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

struct InvestorListItem : View{
    
    private var investorName:String?
    private var investorCurrentStakePercentage:Float?
    private var investorCurrentTotal:Double?
    
    public init(name: String, currentStakePercentage: Float, currentTotal: Double){
        self.investorName = name
        self.investorCurrentStakePercentage = currentStakePercentage
        self.investorCurrentTotal = currentTotal
    }
    
    var body: some View{
        return ZStack{
            HStack{
                Text(self.investorName!)
                Spacer().frame(width: 50)
                Text(String(format: "%.2f", self.investorCurrentStakePercentage!) + "%")
                Spacer()
                Text(String(format: "%.2f", self.investorCurrentTotal!) + "$")
                Spacer()
            }
                .font(.custom("", size: 19.0))
                .frame(height: 75.0, alignment: .center)

            
        }
    }
}


#if DEBUG
struct InvestorView_Previews: PreviewProvider {
    static var previews: some View {
        InvestorsView()
    }
}
#endif
