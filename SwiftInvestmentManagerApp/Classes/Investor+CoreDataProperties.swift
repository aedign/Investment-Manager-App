//
//  Investor+CoreDataProperties.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 4/2/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//
//

import Foundation
import CoreData


extension Investor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Investor> {
        return NSFetchRequest<Investor>(entityName: "Investor")
    }

    @NSManaged public var currentStakePercentage: Float
    @NSManaged public var currentTotal: Double
    @NSManaged public var earningsAmount: Double
    @NSManaged public var earningsPercentage: Float
    @NSManaged public var initialInvestment: Double
    @NSManaged public var name: String?
    @NSManaged public var change: NSSet?
    @NSManaged public var investorGroup: InvestorGroup?

}

// MARK: Generated accessors for change
extension Investor {

    @objc(addChangeObject:)
    @NSManaged public func addToChange(_ value: InvestorChange)

    @objc(removeChangeObject:)
    @NSManaged public func removeFromChange(_ value: InvestorChange)

    @objc(addChange:)
    @NSManaged public func addToChange(_ values: NSSet)

    @objc(removeChange:)
    @NSManaged public func removeFromChange(_ values: NSSet)

}
