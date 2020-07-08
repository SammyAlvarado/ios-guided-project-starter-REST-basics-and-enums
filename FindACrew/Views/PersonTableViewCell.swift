//
//  PersonTableViewCell.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PersonCell"

    var person: Person? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!

    private func updateViews() {
        guard let person = person else { return }

        nameLabel.text = person.name
        heightLabel.text = "\(person.height) cm"
        birthYearLabel.text = "Born \(person.birthYear)"
    }
}
