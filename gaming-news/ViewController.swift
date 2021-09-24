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
    @IBOutlet weak var saveText: UIButton!
    
    @IBOutlet weak var commentAdd: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fileName: UITextField!
    
    var parentViewCon:TableViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let parent = parentViewCon {
             textView.text = parent.notes[parent.currentNote].title
        }else {
            textView.text = "empty..."
        }
        
        firebaseService.downloadImage(fileName: "fortnite.jpg", caller:self)
        
        // firebaseService.testUpload()
        // firebaseService.testDownload()
    
        
        
        
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        
        
        print("save pressed")
        if let img = imageView.image, let name = fileName.text {
            firebaseService.uploadImage(filename: name, image: img)
        }
        
        // update data
        
        if let p = parentViewCon {
            let note = p.notes[p.currentNote]
            note.title = textView.text
            p.updateNote(note: note)
        }
    
        
        // insert data
        
        
        if let x = parentViewCon {
            let note = x.notes[x.currentNote]
            note.comment = commentAdd.text
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
    
    
    
    @IBAction func pressDelete(_ sender: Any) {
        
        if let x = parentViewCon {
            x.simpleDelete()
        }
    }

    
    
    
}

