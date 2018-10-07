//
//  ChatCell.swift
//  VChennur
//
//  Created by Vasu Yarasu on 02/10/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    let chatLabel = UILabel()
    let chatBubble = UIView()
    let chatTime = UILabel()
    
    var leadingConstaint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var centerXconstraint: NSLayoutConstraint!
    
    
    var isAdmin: Bool!{
        didSet{
            chatBubble.backgroundColor = isAdmin ? .white : #colorLiteral(red: 0.2120109187, green: 0.5957864148, blue: 0.8629111472, alpha: 1)
            chatLabel.textColor = isAdmin ? .black : .white
            chatTime.textColor = isAdmin ? .lightGray : .darkGray
            chatTime.textAlignment = isAdmin ? .left : .right
           
            centerXconstraint.isActive = true
            if isAdmin{
                leadingConstaint.isActive = true
                trailingConstraint.isActive = false
                
            }
            else{
                leadingConstaint.isActive = false
                trailingConstraint.isActive = true
            }
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        
        chatBubble.layer.cornerRadius = 10
        chatBubble.translatesAutoresizingMaskIntoConstraints = false
        
        chatTime.numberOfLines = 0
        chatTime.font = UIFont.italicSystemFont(ofSize: 12)
        chatTime.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(chatBubble)
        addSubview(chatLabel)
        addSubview(chatTime)
    
        chatLabel.numberOfLines = 0
        chatLabel.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        chatLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //set up Constraints
        let chatLblConstraints = [chatLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
         chatLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        chatLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
        
        chatTime.topAnchor.constraint(equalTo: chatLabel.bottomAnchor),chatTime.widthAnchor.constraint(equalTo: chatLabel.widthAnchor),
        
        chatBubble.topAnchor.constraint(equalTo: chatLabel.topAnchor, constant: -8),chatBubble.leadingAnchor.constraint(equalTo: chatLabel.leadingAnchor, constant: -8),chatBubble.bottomAnchor.constraint(equalTo: chatTime.bottomAnchor, constant: 8),chatBubble.trailingAnchor.constraint(equalTo: chatLabel.trailingAnchor, constant: 8)]
        NSLayoutConstraint.activate(chatLblConstraints)
        
        leadingConstaint = chatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        trailingConstraint = chatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        centerXconstraint = chatTime.centerXAnchor.constraint(equalTo: chatLabel.centerXAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
