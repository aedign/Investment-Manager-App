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
    
    @Environment(\.colorScheme) var colorScheme
    @State private var name:String = ""
    @State private var initialInvestment:String = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
            NavigationView{
                VStack(spacing: 10){
                    
                    Text("Name:").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Enter Name", text: self.$name)
                        .padding()
                    
                    Text("Initial Investment:").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Enter $", text: self.$initialInvestment)
                        .keyboardType(UIKeyboardType.decimalPad)
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        if(self.name.count > 1 && Double(self.initialInvestment)! > 0){
                            self.addInvestor()
                        }
                    })
                    {
                        Text("Confirm")
                    }
                        .frame(width: 180, height: 60, alignment: .center)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                                    
  
                }
                .padding()
                .navigationBarTitle("Add Investor")
                }
            }
        }
    }
    
    
    private func addInvestor(){
         
        let newInvestor = Investor(context: managedObjectContext)
        newInvestor.name = self.name
        newInvestor.currentStakePercentage = 13.0
        newInvestor.initialInvestment = Double(self.initialInvestment)!
        newInvestor.currentTotal = newInvestor.initialInvestment
        
        
        print("name: " + newInvestor.name!)
        print("money: \(newInvestor.currentTotal)")
        
        
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
