//
//  UserTwoChatCell.swift
//  ChatApp
//
//  Created by Louis Nelson Levoride on 11/08/16.
//  Copyright © 2016 LouisNelson. All rights reserved.
//

import UIKit

class UserTwoChatCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var timeStampLbl: UILabel!
    
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    var chatObject:chatMessage?{
        
        didSet{
            
            if let user = chatObject?.sender{
                
                if let profileImg = user.profiileImage
                {
                    profileImage.image = profileImg
                }
            }
            
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
        simpleCornersAndBorders().makeImageCircular(profileImage)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
