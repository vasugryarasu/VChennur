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
    
    var leadingConstaint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    
    var isUser: Bool!{
        didSet{
            chatBubble.backgroundColor = isUser ? .white : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            chatLabel.textColor = isUser ? .black : .white
            
            if isUser{
                leadingConstaint.isActive = true
                trailingConstraint.isActive = false
            }
            else{
                leadingConstaint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        chatBubble.layer.cornerRadius = 10
        chatBubble.translatesAutoresizingMaskIntoConstraints = false

        addSubview(chatBubble)
        addSubview(chatLabel)
        
        chatLabel.numberOfLines = 0
        chatLabel.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        chatLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //set up Constraints
        let chatLblConstraints = [chatLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        chatLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        chatLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
        
        chatBubble.topAnchor.constraint(equalTo: chatLabel.topAnchor, constant: -8),chatBubble.leadingAnchor.constraint(equalTo: chatLabel.leadingAnchor, constant: -8),chatBubble.bottomAnchor.constraint(equalTo: chatLabel.bottomAnchor, constant: 8),chatBubble.trailingAnchor.constraint(equalTo: chatLabel.trailingAnchor, constant: 8)]
        NSLayoutConstraint.activate(chatLblConstraints)
        
        leadingConstaint = chatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        trailingConstraint = chatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
