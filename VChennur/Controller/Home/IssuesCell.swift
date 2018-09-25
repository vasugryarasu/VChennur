//
//  IssuesCell.swift
//  VNetha
//
//  Created by Vasu Yarasu on 19/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit

class IssuesCell: UITableViewCell {
    @IBOutlet weak var issueIDLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       issueIDLbl.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        issueIDLbl.bounds.size.width = 30
        issueIDLbl.bounds.size.height = 144
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
