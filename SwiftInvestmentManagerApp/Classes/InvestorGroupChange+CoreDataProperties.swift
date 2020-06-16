//
//  InvestorGroupChange+CoreDataProperties.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 6/15/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//
//

import Foundation
import CoreData


extension InvestorGroupChange {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InvestorGroupChange> {
        return NSFetchRequest<InvestorGroupChange>(entityName: "InvestorGroupChange")
    }

    @NSManaged public var date: Date
    @NSManaged public var moneyAdded: Double
    @NSManaged public var newTotal: Double
    @NSManaged public var previousTotal: Double
    @NSManaged public var reason: String
    @NSManaged public var madeBy: InvestorGroup

}
