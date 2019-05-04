//
//  ViewController.swift
//  SomeChat
//
//  Created by alien on 2019/5/2.
//  Copyright © 2019 z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var chatRoomScrollView: UIScrollView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var chatMessageTextField: UITextField!
    
    var labelHeight: CGFloat = 0
    
    @IBAction func sendMessage(_ sender: UIButton) {
        guard let name = nickNameTextField.text, let message = chatMessageTextField.text else {return}
        let messageLabel = UILabel()
        messageLabel.text = name + "\n" + message
        messageLabel.numberOfLines = 0
        messageLabel.frame = CGRect(x: 0, y: labelHeight, width: chatRoomScrollView.frame.width, height: messageLabel.frame.height)
        messageLabel.sizeToFit()
        chatRoomScrollView.addSubview(messageLabel)
        labelHeight += messageLabel.frame.height + 8
        
        nickNameTextField.text = nil
        chatMessageTextField.text = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

