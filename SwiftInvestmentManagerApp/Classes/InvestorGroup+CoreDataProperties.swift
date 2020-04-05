//
//  InvestorGroup+CoreDataProperties.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 4/2/20.
//  Copyright © 2020 Andres Di Gregorio. All rights reserved.
//
//

import Foundation
import CoreData


extension InvestorGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InvestorGroup> {
        return NSFetchRequest<InvestorGroup>(entityName: "InvestorGroup")
    }

    @NSManaged public var currentEarningsAmount: Double
    @NSManaged public var currentEarningsPercentage: Float
    @NSManaged public var currentTotal: Double
    @NSManaged public var initialInvestment: Double
    @NSManaged public var lastChangeDate: Date?
    @NSManaged public var change: NSSet?
    @NSManaged public var investor: NSSet?

}

// MARK: Generated accessors for change
extension InvestorGroup {

    @objc(addChangeObject:)
    @NSManaged public func addToChange(_ value: Investor)

    @objc(removeChangeObject:)
    @NSManaged public func removeFromChange(_ value: Investor)

    @objc(addChange:)
    @NSManaged public func addToChange(_ values: NSSet)

    @objc(removeChange:)
    @NSManaged public func removeFromChange(_ values: NSSet)

}

// MARK: Generated accessors for investor
extension InvestorGroup {

    @objc(addInvestorObject:)
    @NSManaged public func addToInvestor(_ value: InvestorGroupChange)

    @objc(removeInvestorObject:)
    @NSManaged public func removeFromInvestor(_ value: InvestorGroupChange)

    @objc(addInvestor:)
    @NSManaged public func addToInvestor(_ values: NSSet)

    @objc(removeInvestor:)
    @NSManaged public func removeFromInvestor(_ values: NSSet)

}
