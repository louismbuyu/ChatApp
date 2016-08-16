//
//  UserOneChatCell.swift
//  ChatApp
//
//  Created by Louis Nelson Levoride on 11/08/16.
//  Copyright © 2016 LouisNelson. All rights reserved.
//

import UIKit

class UserOneChatCell: UITableViewCell {
    
    @IBOutlet weak var timeStampLbl: UILabel!
    
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    var chatObject:chatMessage?{
        
        didSet{
            
            if let message = chatObject?.messageText{
                messageBodyLbl.text = message
            }
            
            if let time = chatObject?.timeStamp{
                timeStampLbl.text = simpleDate().date(time)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
