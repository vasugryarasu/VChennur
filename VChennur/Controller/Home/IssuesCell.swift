//
//  IssuesCell.swift
//  VNetha
//
//  Created by Vasu Yarasu on 19/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit

class IssuesCell: UITableViewCell {
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var issueNameLbl: UILabel!
    @IBOutlet weak var issueTimeLbl: UILabel!
    @IBOutlet weak var issueIdLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     status.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        statusLbl.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
