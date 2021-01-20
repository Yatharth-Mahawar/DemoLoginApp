//
//  datamodel.swift
//  LoginDemo
//
//  Created by Yatharth Mahawar on 1/20/21.
//

import Foundation
struct Task:Codable {
    var id:String?
    let name:String
    init(name:String) {
        self.name = name
    }
}
