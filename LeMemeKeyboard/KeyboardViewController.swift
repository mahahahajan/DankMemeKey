//
//  KeyboardViewController.swift
//  LeMemeKeyboard
//
//  Created by Pulkit Mahajan on 11/7/15.
//  Copyright (c) 2015 Pulkit Mahajan. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var name = ""
    var buttonImage : UIImage!
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonTitles1 = ["1", "2", "3", "4"]
        let buttonTitles2 = ["A", "S", "D", "F"]
        let buttonTitles3 = ["CHG","Z","X", "C"]
        
        print("yay")
        let row1 = createRowOfButtons(buttonTitles1)
        let row2 = createRowOfButtons(buttonTitles2)
        let row3 = createRowOfButtons(buttonTitles3)
        
        self.view.addSubview(row1)
        self.view.addSubview(row2)
        
        self.view.addSubview(row3)
        
        row1.translatesAutoresizingMaskIntoConstraints = false
        row2.translatesAutoresizingMaskIntoConstraints = false
        row3.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsToInputView(self.view, rowViews: [row1, row2, row3])
    }
    
    func createRowOfButtons(buttonTitles: [NSString]) -> UIView {
        
        var buttons = [UIButton]()
        let keyboardRowView = UIView(frame: CGRectMake(0, 0, 320, 50))
        
        for buttonTitle in buttonTitles{
            
            let button = createButtonWithTitle(buttonTitle as String) // 1
            buttons.append(button)
            keyboardRowView.addSubview(button)
        }
        
        addIndividualButtonConstraints(buttons, mainView: keyboardRowView)
        
        return keyboardRowView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
    }
    
    
    
    func createButtonWithTitle(title: String) -> UIButton {
        
        
        
        let button1 = UIButton(type: .Custom)
        button1.frame = CGRectMake(0, 0, 20, 20)
        button1.setTitle(title, forState: .Normal)
        button1.sizeToFit()
        button1.titleLabel?.font = UIFont.systemFontOfSize(15)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button1.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        
        
        
        
        
        buttonImage = UIImage(named: getNameFromIndex(title))! as UIImage
        
        button1.setImage(buttonImage, forState: UIControlState.Normal)
        button1.userInteractionEnabled = true
        
        
        button1.addTarget(self, action: "didTapButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button1
        
    }
    
    func getNameFromIndex(title: String) -> String {
        
        var name: String!
        if(title == "1"){
            name = "3a5.jpg"
        }
        else if(title == "2")
        {
            name = "3cd8a33a.png"
        }
        else if(title == "A"){
            name = "22118345.jpg"
        }
        else if(title == "3")
        {
            name = "6e8.jpg"
        }
        else if(title == "4")
        {
            name = "giphy-1.gif"
        }
        else if(title == "S")
        {
            name = "c2d.jpg"
        }
        else if(title == "D")
        {
            name = "giphy-4.gif"
        }
        else if(title == "F")
        {
            name = "64662036.jpg"
        }
        else if(title == "CHG")
        {
            name = "classica_back-button-1_flat-square-white-on-yellow_512x512.png"
        }
        else if(title == "Z")
        {
            name = "Dec813-funny-memes-63.jpg"
        }
        else if(title == "X")
        {
            name = "impossibru.jpeg"
        }
        else if(title == "C")
        {
            name = "oh-really.png"
        }
        else{
            name="I-Like-Yer-Style-Dude.jpg"
        }
        return name
    }
    
        func didTapButton(sender: UIButton!) {
        
        print(("REACHED HERE"))
        
        let button : UIButton = sender!
        
        let proxy = textDocumentProxy
        
        if let title = button.titleForState(.Normal) {
            switch title {
            case "BP" :
                proxy.deleteBackward()
            case "RETURN" :
                proxy.insertText("\n")
            case "SPACE" :
                proxy.insertText(" ")
            case "CHG" :
                self.advanceToNextInputMode()
            default :
                let imagec = UIImage(named: getNameFromIndex(title))
                // let pasteboard = UIPasteboard.generalPasteboard()
                // pasteboard.image = imagec
                
                // let data = NSData(data: UIImagePNGRepresentation(imagec!)! )
                // UIPasteboard.generalPasteboard().setData(data, forPasteboardType: "3a5.jpg")
                
                let pbWrapped: UIPasteboard? = UIPasteboard.generalPasteboard()
                if let pb = pbWrapped {
                    let type = UIPasteboardTypeListImage[0] as! String
                    if (imagec != nil) {
                        pb.setData(UIImagePNGRepresentation(imagec!)!, forPasteboardType: type)
                        let readDataWrapped: NSData? = pb.dataForPasteboardType(type)
                        if let readData = readDataWrapped {
                            let readImage = UIImage(data: readData, scale: 2)
                            print("\(imagec) == \(pb.image) == \(readImage)")
                        }
                    }
                }
            }
        }
    }
    
    func addIndividualButtonConstraints(buttons: [UIButton], mainView: UIView){
        
        for (index, button) in buttons.enumerate() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: mainView, attribute: .Top, multiplier: 1.0, constant: 1)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: mainView, attribute: .Bottom, multiplier: 1.0, constant: -1)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == buttons.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: mainView, attribute: .Right, multiplier: 1.0, constant: -1)
                
            }else{
                
                let nextButton = buttons[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: nextButton, attribute: .Left, multiplier: 1.0, constant: -1)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: mainView, attribute: .Left, multiplier: 1.0, constant: 1)
                
            }else{
                
                let prevtButton = buttons[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: prevtButton, attribute: .Right, multiplier: 1.0, constant: 1)
                
                let firstButton = buttons[0]
                let widthConstraint = NSLayoutConstraint(item: firstButton, attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
                
                widthConstraint.priority = 800
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    
    
    func addConstraintsToInputView(inputView: UIView, rowViews: [UIView]){
        
        for (index, rowView) in rowViews.enumerate() {
            let rightSideConstraint = NSLayoutConstraint(item: rowView, attribute: .Right, relatedBy: .Equal, toItem: inputView, attribute: .Right, multiplier: 1.0, constant: -1)
            
            let leftConstraint = NSLayoutConstraint(item: rowView, attribute: .Left, relatedBy: .Equal, toItem: inputView, attribute: .Left, multiplier: 1.0, constant: 1)
            
            inputView.addConstraints([leftConstraint, rightSideConstraint])
            
            var topConstraint: NSLayoutConstraint
            
            if index == 0 {
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .Top, relatedBy: .Equal, toItem: inputView, attribute: .Top, multiplier: 1.0, constant: 0)
                
            }else{
                
                let prevRow = rowViews[index-1]
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .Top, relatedBy: .Equal, toItem: prevRow, attribute: .Bottom, multiplier: 1.0, constant: 0)
                
                let firstRow = rowViews[0]
                let heightConstraint = NSLayoutConstraint(item: firstRow, attribute: .Height, relatedBy: .Equal, toItem: rowView, attribute: .Height, multiplier: 1.0, constant: 0)
                
                heightConstraint.priority = 800
                inputView.addConstraint(heightConstraint)
            }
            inputView.addConstraint(topConstraint)
            
            var bottomConstraint: NSLayoutConstraint
            
            if index == rowViews.count - 1 {
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .Bottom, relatedBy: .Equal, toItem: inputView, attribute: .Bottom, multiplier: 1.0, constant: 0)
                
            }else{
                
                let nextRow = rowViews[index+1]
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .Bottom, relatedBy: .Equal, toItem: nextRow, attribute: .Top, multiplier: 1.0, constant: 0)
            }
            
            inputView.addConstraint(bottomConstraint)
        }
    }
}