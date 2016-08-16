//
//  RecentChatCell.swift
//  ChatApp
//
//  Created by Louis Nelson Levoride on 11/08/16.
//  Copyright © 2016 LouisNelson. All rights reserved.
//

import UIKit

class RecentChatCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var lastMessage: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var seenImage: UIImageView!
    
    var recentChat: recentMessage?{
       
        didSet{
            
            if let user = recentChat?.otherUser{
                
                profileImage.image = user.profiileImage
                username.text = user.displayName
                
                if let messageRead = recentChat?.messageSeen{
                    if messageRead == true{
                        seenImage.hidden = true
                    }else{
                        seenImage.hidden = false
                        seenImage.image = user.profiileImage
                    }
                }
            }
            
            if let message = recentChat?.lastMessage{
                lastMessage.text = message
            }
            
            
            
            if let time = recentChat?.timeStamp
            {
                
                timeStamp.text = simpleDate().date(time)
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        simpleCornersAndBorders().makeImageCircular(profileImage)
        simpleCornersAndBorders().makeImageCircular(seenImage)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
