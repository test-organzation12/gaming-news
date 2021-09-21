//
//  ViewController.swift
//  gaming-news
//
//  Created by abdulahi roble on 21/09/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveText: UIButton!
    
    
    var db = Firestore.firestore()
    let notes = "notes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startListener()
        // Do any additional setup after loading the view.
    }
    
    func startListener() {
        db.collection(notes).addSnapshotListener { snapshot, error in
            print("hi from firebase")
        }
    }
    
}

