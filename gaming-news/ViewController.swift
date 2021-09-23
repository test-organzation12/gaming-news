//
//  ViewController.swift
//  gaming-news
//
//  Created by abdulahi roble on 21/09/2021.
//

import UIKit
import Firebase

var firebaseService = FirebaseService()


class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var commentView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveText: UIButton!
    
    var parentViewCon:TableViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let parent = parentViewCon {
             textView.text = parent.notes[parent.currentNote].title
        }else {
            textView.text = "empty..."
        }
        
        firebaseService.testUpload()
        firebaseService.testDownload()
        
        
        
        
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        
        // update data
        /*
        if let p = parentViewCon {
            let note = p.notes[p.currentNote]
            note.title = textView.text
            // p.simpleEdit(note: note)
        }
        */
        
        // insert data
        
        if let x = parentViewCon {
            let note = x.notes[x.currentNote]
            note.title = textView.text
            x.insertData(note: note)
        }
        
        
        /*
        if let x = parentViewCon {
            let note = x.comments[x.currentComment]
            note.fortnitecomment = commentView.text
            x.insertCommentData(comment: note)
        }
        */
        
    }
    
}

