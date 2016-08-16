//
//  RecentChats.swift
//  ChatApp
//
//  Created by Louis Nelson Levoride on 11/08/16.
//  Copyright © 2016 LouisNelson. All rights reserved.
//

import UIKit

class RecentChats: UITableViewController {
    
    var recentMessages = [recentMessage]()
    
    var otherUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setUpSampleRecentMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.tabBarController?.tabBar.hidden = false
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.recentMessages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! RecentChatCell
        
        if let recentMessageObj:recentMessage = self.recentMessages[indexPath.row]{
            
            cell.recentChat = recentMessageObj
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let recentMessageObj:recentMessage = self.recentMessages[indexPath.row]{
            
            self.otherUser = recentMessageObj.otherUser
            
            self.performSegueWithIdentifier("chat_seg", sender: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "chat_seg"{
         
            let dest = segue.destinationViewController as! ChatVC
            
            dest.otheruser = otherUser
        }
    }

    func setUpSampleRecentMessages(){
        
        let reidHoffman = User()
        
        reidHoffman.displayName = "Reid Hoffman"
        reidHoffman.id = "reidhoffman"
        reidHoffman.profiileImage = UIImage(named: "reidImage")
        
        
        let recentMsgReid = recentMessage()
        recentMsgReid.otherUser = reidHoffman
        recentMsgReid.lastMessage = "Hi, Reid here. Founder of LinkedIn. Heard about your startup."
        recentMsgReid.messageSeen = false
        recentMsgReid.timeStamp = NSDate()
        
        
        let elonMusk = User()
        
        elonMusk.displayName = "Elon Musk"
        elonMusk.id = "elonmusk"
        elonMusk.profiileImage = UIImage(named: "elonImage")
        
        
        let recentMsgElon = recentMessage()
        recentMsgElon.otherUser = elonMusk
        recentMsgElon.lastMessage = "Hi, Elon here. Founder of Tesla. Let's change the world."
        recentMsgElon.messageSeen = false
        recentMsgElon.timeStamp = NSDate()
        
        
        let steveJobs = User()
        
        steveJobs.displayName = "Steve Jobs"
        steveJobs.id = "stevejobs"
        steveJobs.profiileImage = UIImage(named: "steveImage")
        
        
        let recentMsgSteve = recentMessage()
        recentMsgSteve.otherUser = steveJobs
        recentMsgSteve.lastMessage = "Make sure you always think differently!"
        recentMsgSteve.messageSeen = true
        recentMsgSteve.timeStamp = NSDate()
        
        
        let billGates = User()
        
        billGates.displayName = "Bill Gates"
        billGates.id = "billgates"
        billGates.profiileImage = UIImage(named: "billImage")
        
        
        let recentMsgBill = recentMessage()
        recentMsgBill.otherUser = billGates
        recentMsgBill.lastMessage = "Bill here, founder of Microsoft!"
        recentMsgBill.messageSeen = true
        recentMsgBill.timeStamp = NSDate()
        
        let arrayOfRecentMessages = [recentMsgReid,recentMsgElon,recentMsgSteve,recentMsgBill]
        
        recentMessages = arrayOfRecentMessages
        self.tableView.reloadData()
    }

}
