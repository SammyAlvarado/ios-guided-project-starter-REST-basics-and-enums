//
//  Person.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Person: Decodable {
    let name: String
    let birthYear: String
    let height: String
}

struct PersonSearch: Decodable {
    let results: [Person]
}
