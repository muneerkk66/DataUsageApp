//
//  AppExtensions.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
extension String {}

extension Sequence where Element: Hashable {
    func unique() -> [Element] {
        NSOrderedSet(array: self as! [Any]).array as! [Element]
    }
}

extension Double {
    func truncate(to places: Int) -> Double {
        return Double(Int((pow(10, Double(places)) * self).rounded())) / pow(10, Double(places))
    }
}

extension Array where Element: Comparable {
    func isAscending() -> Bool {
        return zip(self, dropFirst()).allSatisfy(<=)
    }

    func isDescending() -> Bool {
        return zip(self, dropFirst()).allSatisfy(>=)
    }
}
