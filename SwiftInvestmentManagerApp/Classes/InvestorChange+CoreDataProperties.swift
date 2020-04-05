//
//  InvestorChange+CoreDataProperties.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 4/2/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//
//

import Foundation
import CoreData


extension InvestorChange {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InvestorChange> {
        return NSFetchRequest<InvestorChange>(entityName: "InvestorChange")
    }

    @NSManaged public var date: Date?
    @NSManaged public var moneyAdded: Double
    @NSManaged public var newStakePercentage: Float
    @NSManaged public var newTotal: Double
    @NSManaged public var previousStakePercentage: Float
    @NSManaged public var previousTotal: Double
    @NSManaged public var reason: String?
    @NSManaged public var madeBy: Investor?

}
