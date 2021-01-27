//
//  User.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/18/21.
//

import Foundation

class User {
    private let id: String
    private let familyId: String
    private let lastLocation: [Double]
    
    init(_ id: String, _ familyId: String = "") {
        self.id = id
        self.familyId = familyId
        self.lastLocation = []
    }
}
