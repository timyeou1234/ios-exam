//
//  Contact.swift
//  iOS_Exam
//
//  Created by YeouTimothy on 2019/1/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

struct ContactModel: Codable {
    var name    :NameModel
    var dob     :Dob
    var location:Location
    var phone   :String
    var cell    :String
    var email   :String
}

struct NameModel: Codable {
    var first   :String
    var last    :String
    var title   :String
}

struct Dob: Codable {
    var age     :Int
    var date    :String
}

struct Location: Codable {
    var state   :String
    var city    :String
    var street  :String
}
