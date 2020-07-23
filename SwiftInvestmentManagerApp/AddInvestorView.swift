//
//  AddInvestorView.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 4/4/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//

import SwiftUI
import CoreData

struct AddInvestorView: View {
    
    @State private var newInvestor:Investor?
    @State private var addInvestorButtonPressed = false
    @State private var investorName:String = ""
    @State private var investorInitialInvestment:String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    private var calcStake : Float {
        if investorInitialInvestment.isEmpty || investorInitialInvestment == "0" {return 0.0}
        else if investorGroup.first?.groupInvestment == 0 {return 100}
        else{
            let iniInv: Float = Float(investorInitialInvestment)!
            let groupTotal: Float = Float(investorGroup.first?.groupInvestment ?? 0)
            return (iniInv / (iniInv + groupTotal)) * 100
    }}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Investor.entity(), sortDescriptors:[NSSortDescriptor(key: "name", ascending: true)]) var investorList: FetchedResults<Investor>
    @FetchRequest(entity: InvestorGroup.entity(), sortDescriptors:[]) var investorGroup: FetchedResults<InvestorGroup>
    
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Text("Name:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .medium, design: .default))
                TextField("Enter Name", text: self.$investorName)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    
                Text("Initial Investment:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .medium, design: .default))
                TextField("Enter $", text: self.$investorInitialInvestment)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    .keyboardType(UIKeyboardType.numberPad)
                    
                VStack(alignment: .leading){
                    Text("Stake")
                    .font(.system(size: 30, weight: .medium, design: .default))
                        HStack{
                            Text(String(format: "%.2f", self.calcStake))
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        Text("%")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        }
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack{
                    Text("Press and hold")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Button("Add Investor"){}
                        .frame(minWidth: 100, maxWidth: 200, minHeight: 34, maxHeight: 34, alignment: .center)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                        .contentShape(Rectangle()) // makes the enitre button perform the action and not just the etxt
                        .padding()
                        .simultaneousGesture(LongPressGesture(minimumDuration: 1, maximumDistance: 1).onEnded{_ in
                            if(self.investorName.count > 1 && !self.investorInitialInvestment.isEmpty && Double(self.investorInitialInvestment)! > 0){
                                self.addInvestor()
                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                                self.printAll()
                                self.mode.wrappedValue.dismiss()
                            }
                        })
                        .background(self.addInvestorButtonPressed ? Color.green : Color.blue)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .scaleEffect(self.addInvestorButtonPressed ? 1.2 : 1.0)
                        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: {
                            pressing in
                            withAnimation(.easeInOut(duration: 0.8)){
                                self.addInvestorButtonPressed = pressing
                            }
                        }, perform :{})
                        .padding()
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .navigationBarTitle("Add Investor")
        }.background(self.colorScheme == .dark ? Color.black : Color.white)
        .onTapGesture {UIApplication.shared.endEditing()}
    }
    private func printAll(){
        
        print("ALL")
        for group in investorGroup{
            print("\(String(describing: group.name))")
            print("\(String(describing: group.hasMany))")
            print("\(String(describing: group.makes))")
        }
        print("")
        for inv in investorList {
            print("\(String(describing: inv.name))")
            print("\(String(describing: inv.hasOne))")
            print("\(inv.currentStakePercentage)")
            print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEVEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE")
            print(inv.makes.count)

            

        }
    }
        
    private func addInvestor(){

        if self.investorGroup.isEmpty {self.addInvestorGroup()}
        
        if !self.investorList.contains(where:{investor in return investor.name.elementsEqual(self.investorName)}) {
            let newInvestor = Investor(context: managedObjectContext)
            newInvestor.name = self.investorName
            newInvestor.initialInvestment = Double(self.investorInitialInvestment)!
            newInvestor.currentTotal = newInvestor.initialInvestment
            newInvestor.currentStakePercentage = self.calcStake
            newInvestor.earningsAmount = 0
            newInvestor.earningsPercentage = 0
        
            addInvestorChange(investor: newInvestor)
            self.investorGroup.first!.addToHasMany(newInvestor)
            addGroupChange(newInvestor: newInvestor)
         
            updatePercentages()
            save()
            printAll()
        }
     }
    
    private func addInvestorGroup(){
        
        let newInvestorGroup = InvestorGroup(context: managedObjectContext)
        newInvestorGroup.lastChangeDate = Date()
        newInvestorGroup.name = "Roomies"
        save()
    }
    
    private func addGroupChange(newInvestor:Investor){
        
        let groupChange = InvestorGroupChange(context: managedObjectContext)
        groupChange.date = Date()
        groupChange.madeBy = self.investorGroup.first!
        groupChange.moneyAdded = newInvestor.initialInvestment
        groupChange.previousTotal = self.investorGroup.first!.groupInvestment
        groupChange.newTotal = self.investorGroup.first!.groupInvestment + groupChange.moneyAdded
        self.investorGroup.first!.groupInvestment = groupChange.newTotal
        groupChange.reason = "\(String(describing: newInvestor.name)) was added"
    
        self.investorGroup.first!.addToMakes(groupChange)
    }
    
    private func addInvestorChange(investor: Investor){
    

        let investorChange = InvestorChange(context: managedObjectContext)
        
        investorChange.date = Date()
        investorChange.madeBy = investor
        investorChange.moneyAdded = investor.initialInvestment
      //  investorChange.previousStakePercentage
        investorChange.newStakePercentage = investor.currentStakePercentage
        investorChange.newTotal = investor.currentTotal
        
        investor.addToMakes(investorChange)
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
    
    private func updatePercentages() -> Void{
        
        let group:Double = investorGroup[0].groupInvestment
        
        for investor in investorList{
            let individual:Double = investor.initialInvestment
            investor.currentStakePercentage = Float((individual / (group)) * 100)
        }
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
/*
struct InvestorInfo: View{
    
    @Environment(\.colorScheme) var colorScheme
    @State fileprivate var data:String = " "
    private var textWidth: CGFloat
    private var infoType: String
    private var onTextField: String
    private var keyboardType: UIKeyboardType
    
    public init(infoType: String, onTextField: String? = nil, keyboardType: UIKeyboardType){
        
        self.infoType = infoType
        self.keyboardType = keyboardType
        
        if let text = onTextField{
            self.onTextField = text
            print(text)
        }
        else {
            self.onTextField = ""
        }
        
        self.textWidth = (UIScreen.main.bounds.width - 20)
        
        if infoType.count < 10{
            self.textWidth /= 5
        }
        else if infoType.count > 10 && infoType.count < 20{
            self.textWidth /= 3
        }
        else if infoType.count > 20 && infoType.count < 30{
            self.textWidth /= 2
        }
    }
    
    var body: some View {
        GeometryReader{geometry in
            HStack{
                Text(self.infoType)
                    .fontWeight(.bold)
                    .frame(width: self.textWidth, height: geometry.size.height, alignment: .center)
                    .foregroundColor(Color.white)

                TextField(" " + self.onTextField, text: self.$data)
                    .keyboardType(self.keyboardType)
                    .background(Color.white)
                   // .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: (UIScreen.main.bounds.width - 37) - self.textWidth - 10, height: geometry.size.height - 5, alignment: .trailing)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 2.5))
                
                 }
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .font(.system(size: geometry.size.height / 3)).font(.system(.body, design: .rounded))
                .background(Color.gray)
                // .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
               //  .contentShape(RoundedRectangle(cornerRadius: 17.0))
                  //   .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 4.0))
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 14, alignment: .center)
    }

}
*/

struct AddInvestorView_Previews: PreviewProvider {
    static var previews: some View {
        AddInvestorView()
    }
}
