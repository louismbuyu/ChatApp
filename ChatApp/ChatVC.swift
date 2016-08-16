//
//  ChatVC.swift
//  ChatApp
//
//  Created by Louis Nelson Levoride on 11/08/16.
//  Copyright © 2016 LouisNelson. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var inputUIView: UIView!
    
    @IBOutlet weak var inputTextView: UITextView!
    
    @IBOutlet weak var sendButton: UIButton!
    var placeholderLabel : UILabel!
    var bottomConstraint: NSLayoutConstraint?
    
    let me = User()
    var otheruser = User()
    
    var arrayMessages = [chatMessage]()
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSampleMessages()
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Type message here..."
        placeholderLabel.font = UIFont.italicSystemFontOfSize(inputTextView.font!.pointSize)
        placeholderLabel.sizeToFit()
        inputTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPointMake(5, inputTextView.font!.pointSize / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.hidden = !inputTextView.text.isEmpty
        
        me.displayName = "me"
        me.id = "me"
        me.profiileImage = UIImage(named: "steveImage")
        
        self.title = otheruser.displayName
        
        
        tableView.estimatedRowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        
        bottomConstraint = NSLayoutConstraint(item: inputUIView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleKeyboardNotification), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleKeyboardNotification), name: UIKeyboardWillHideNotification, object: nil)

        
        // Do any additional setup after loading the view.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        if self.arrayMessages.count > 0 {
            let insertionIndex = NSIndexPath(forItem: arrayMessages.count - 1 , inSection: 0)
            self.tableView.scrollToRowAtIndexPath(insertionIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        hideSendButton()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        hideSendButton()
    }
    
    func hideSendButton(){
        if inputTextView.text == "" || inputTextView.isEqual(nil) || inputTextView.text == nil {
            sendButton.enabled = false
        }else{
            sendButton.enabled = true
        }
    }
    
    func textViewDidChange(textView: UITextView)
    {
        placeholderLabel.hidden = !textView.text.isEmpty
        sendButton.enabled = true
    }
    
    func handleKeyboardNotification(notificion: NSNotification){
        
        if let userInfo = notificion.userInfo
        {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
            print(keyboardFrame)
            
            let isKeyboardshowing = notificion.name == UIKeyboardWillShowNotification
            
            bottomConstraint?.constant = isKeyboardshowing ? -keyboardFrame!.height : 0
            
            UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (completed) in
                    
                    if self.arrayMessages.count > 0 {
                        
                        if isKeyboardshowing{
                            
                            let indexPath = NSIndexPath(forItem: self.arrayMessages.count - 1, inSection: 0)
                            
                            self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                        }
                    }
            })
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let countNum:Int = self.arrayMessages.count{
            return countNum
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let theView = UIView()
        
        theView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        return theView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCellWithIdentifier("cell1") as! UserOneChatCell
        let cell2 = tableView.dequeueReusableCellWithIdentifier("cell2") as! UserTwoChatCell
        
        if let chatObj:chatMessage = self.arrayMessages[indexPath.row]
        {
            
            if chatObj.sender.id == me.id
            {
                
                cell1.chatObject = chatObj
                
                return cell1
            }else{
                cell2.chatObject = chatObj
                
                return cell2
            }
        }
    }
    
    @IBAction func sendButtonAction(sender: UIButton) {
        
        if inputTextView.text == "" {
            print("here, entered")
            
        }else{
            let new_message = chatMessage()
             
            new_message.userTwo = otheruser
            new_message.messageText = inputTextView.text
            new_message.timeStamp = NSDate()
            new_message.sender = me
             
             arrayMessages.append(new_message)
            
            let item = arrayMessages.count - 1
            let insertionIndex = NSIndexPath(forItem: item, inSection: 0)
            
            //tableView.beginUpdates()
            
            
            topConstraint.constant = 0
            UIView.animateWithDuration(0.01, animations: {
                self.tableView.insertRowsAtIndexPaths([insertionIndex], withRowAnimation: UITableViewRowAnimation.Bottom)
                
                self.tableView.scrollToRowAtIndexPath(insertionIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
            })
            
            inputTextView.text = nil
        }
        
    }
    
    func setupSampleMessages(){
        
        let messageOne = chatMessage()
        
        messageOne.userTwo = otheruser
        messageOne.messageText = "Hi, I'm me"
        messageOne.timeStamp = NSDate()
        messageOne.sender = me
        
        let messageTwo = chatMessage()
        
        messageTwo.userTwo = me
        messageTwo.messageText = "Well it's nice to meet you me, I'm you"
        messageTwo.timeStamp = NSDate()
        messageTwo.sender = otheruser
        
        let messageThree = chatMessage()
        
        messageThree.userTwo = otheruser
        messageThree.messageText = "Wait a minute, how can you be me when I'm me? That is simply not possible! I'm me and you are you not me. Got it?"
        messageThree.timeStamp = NSDate()
        messageThree.sender = me
        
        let messageFour = chatMessage()
        
        messageFour.userTwo = me
        messageFour.messageText = "Yeah that's what I just said, I'm you and you are me!"
        messageFour.timeStamp = NSDate()
        messageFour.sender = otheruser
        
        let messageFive = chatMessage()
        
        messageFive.userTwo = otheruser
        messageFive.messageText = "Hahaha lol, I'm just kididing. Have you seen the movie Rush hour 2? With Jackie Chan and Chris Tucker? When they enter a Fighting gym?"
        messageFive.timeStamp = NSDate()
        messageFive.sender = me
        
        
        
        let messageSix = chatMessage()
        
        messageSix.userTwo = me
        messageSix.messageText = "Haha, no I havent but i'll def check it out!"
        messageSix.timeStamp = NSDate()
        messageSix.sender = otheruser
        
        let messageSeven = chatMessage()
        
        messageSeven.userTwo = otheruser
        messageSeven.messageText = "Hahaha lol, I'm just kididing. Have you seen the movie Rush hour 2? With Jackie Chan and Chris Tucker? When they enter a Fighting gym?"
        messageSeven.timeStamp = NSDate()
        messageSeven.sender = me
        
        let messageEight = chatMessage()
        
        messageEight.userTwo = otheruser
        messageEight.messageText = "Hahaha lol, I'm just kididing. Have you seen the movie Rush hour 2? With Jackie Chan and Chris Tucker? When they enter a Fighting gym?"
        messageEight.timeStamp = NSDate()
        messageEight.sender = me
        
        arrayMessages.append(messageOne)
        arrayMessages.append(messageTwo)
        arrayMessages.append(messageThree)
        arrayMessages.append(messageFour)
        arrayMessages.append(messageFive)
        arrayMessages.append(messageSix)
        
        arrayMessages.append(messageSeven)
        arrayMessages.append(messageEight)
        
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
