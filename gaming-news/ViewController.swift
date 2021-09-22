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
    
    var parentViewCon:TableViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let parent = parentViewCon {
            textView.text = parent.notes[parent.currentNote].txt
        }else {
            textView.text = "empty..."
        }
        
       
        // Do any additional setup after loading the view.
    }
    
}

