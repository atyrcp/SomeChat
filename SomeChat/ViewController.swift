//
//  ViewController.swift
//  SomeChat
//
//  Created by alien on 2019/5/2.
//  Copyright © 2019 z. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var dataBase: Firestore = {
        FirebaseApp.configure()
        return Firestore.firestore()
    }()
    var labelHeight: CGFloat = 0
    
    @IBOutlet weak var chatRoomScrollView: UIScrollView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var chatMessageTextField: UITextField!
    

    
    @IBAction func sendMessage(_ sender: UIButton) {
        guard let name = nickNameTextField.text, let message = chatMessageTextField.text, !nickNameTextField.text!.isEmpty else {return}
        
        dataBaseAdd(with: message, from: name)
        
        nickNameTextField.text = nil
        chatMessageTextField.text = nil
    }
    
    func dataBaseAdd(with messageContent: String, from user: String) {
        let data = ["content": messageContent, "from": user]
        dataBase.collection("messages").addDocument(data: data)
    }
    
    func dataBaseRead() {
        dataBase.collection("messages").addSnapshotListener { (snapShot, error) in
            if let error = error {
                print(error)
            }
            
            guard let snapShots = snapShot?.documentChanges else {return}
            for document in snapShots {
                let doc = document.document
                guard let name = doc.data()["from"] as? String, let content = doc.data()["content"] as? String else {return}
                
                let messageLabel = UILabel()
                let message = NSMutableAttributedString(string: name + "\n", attributes: [.foregroundColor: UIColor.red])
                message.append(NSAttributedString(string: content, attributes: [NSAttributedString.Key.foregroundColor: UIColor.green]))
                messageLabel.attributedText = message
                messageLabel.numberOfLines = 0
                messageLabel.frame = CGRect(x: 0, y: self.labelHeight, width: self.chatRoomScrollView.frame.width, height: messageLabel.frame.height)
                messageLabel.sizeToFit()
                self.chatRoomScrollView.addSubview(messageLabel)
                self.labelHeight += messageLabel.frame.height + 8
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBaseRead()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
