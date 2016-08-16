//
//  Model.swift
//  ChatApp
//
//  Created by Louis Nelson Levoride on 11/08/16.
//  Copyright © 2016 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class User
{
    var id: String!
    var displayName: String!
    var profiileImage: UIImage?
}

class recentMessage {
    var otherUser: User!
    var timeStamp: NSDate!
    var lastMessage: String!
    var messageSeen:Bool!
}

class chatMessage {
    
    var sender: User!
    var userTwo: User!
    var messageText: String!
    var timeStamp: NSDate!
    var hasRead:Bool!
}

class simpleDate {
    
    func date(date: NSDate) -> String{
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "h:mm a"
        
        let elapsedTimeInSeconds = NSDate().timeIntervalSinceDate(date)
        
        let secondInDays: NSTimeInterval = 60 * 60 * 24
        
        if elapsedTimeInSeconds > 7 * secondInDays {
            dateFormatter.dateFormat = "MM/dd/yy"
        } else if elapsedTimeInSeconds > secondInDays {
            dateFormatter.dateFormat = "EEE"
        }
        
        return dateFormatter.stringFromDate(date)
    }
}

class simpleCornersAndBorders {
    
    func makeImageCircular(image: UIImageView)
    {
        image.layer.cornerRadius = image.layer.frame.width/2
        image.clipsToBounds = true
    }
    
    func makeButton(btn: UIButton,cornerRadius:CGFloat, borderWidth: CGFloat)
    {
        btn.layer.cornerRadius = cornerRadius
        btn.layer.borderWidth = borderWidth
        btn.layer.borderColor = UIColor.whiteColor().CGColor
        btn.clipsToBounds = true
    }
    
}

class RoundView2: UIView
{
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 3.0
        
        layer.shadowColor = UIColor(red: 157/250, green: 157/250, blue: 157/250, alpha: 0.5).CGColor
        layer.shadowOpacity = 2.0
        layer.shadowRadius = 2
        layer.shadowOffset = CGSizeMake(0.1, 0.1)
    }
    
}