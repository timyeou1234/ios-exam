//
//  ContactDetailTableViewCell.swift
//  iOS_Exam
//
//  Created by YeouTimothy on 2019/1/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

class ContactDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
