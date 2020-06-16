//
//  Investor+CoreDataProperties.swift
//  SwiftInvestmentManagerApp
//
//  Created by Andres Di Gregorio on 6/15/20.
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
    @NSManaged public var name: String
    @NSManaged public var hasOne: InvestorGroup
    @NSManaged public var makes: NSSet?

}

// MARK: Generated accessors for makes
extension Investor {

    @objc(addMakesObject:)
    @NSManaged public func addToMakes(_ value: InvestorChange)

    @objc(removeMakesObject:)
    @NSManaged public func removeFromMakes(_ value: InvestorChange)

    @objc(addMakes:)
    @NSManaged public func addToMakes(_ values: NSSet)

    @objc(removeMakes:)
    @NSManaged public func removeFromMakes(_ values: NSSet)

}
