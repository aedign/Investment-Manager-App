//
//  InvestorGroup+CoreDataProperties.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 7/22/20.
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
    @NSManaged public var groupInvestment: Double
    @NSManaged public var lastChangeDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var hasMany: NSSet?
    @NSManaged public var makes: NSSet?

}

// MARK: Generated accessors for hasMany
extension InvestorGroup {

    @objc(addHasManyObject:)
    @NSManaged public func addToHasMany(_ value: Investor)

    @objc(removeHasManyObject:)
    @NSManaged public func removeFromHasMany(_ value: Investor)

    @objc(addHasMany:)
    @NSManaged public func addToHasMany(_ values: NSSet)

    @objc(removeHasMany:)
    @NSManaged public func removeFromHasMany(_ values: NSSet)

}

// MARK: Generated accessors for makes
extension InvestorGroup {

    @objc(addMakesObject:)
    @NSManaged public func addToMakes(_ value: InvestorGroupChange)

    @objc(removeMakesObject:)
    @NSManaged public func removeFromMakes(_ value: InvestorGroupChange)

    @objc(addMakes:)
    @NSManaged public func addToMakes(_ values: NSSet)

    @objc(removeMakes:)
    @NSManaged public func removeFromMakes(_ values: NSSet)

}
