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
    var notes:[Note] = []
    var currentNote = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startListener()
        // Do any additional setup after loading the view.
    }
    
    func startListener() {
        db.collection("notes").addSnapshotListener {(snap, error) in
            if let e = error {
                print("error fetching notes \(e)")
            }else {
                if let s = snap{
                    self.notes.removeAll() // clear array first
                    for doc in s.documents{
                        if let txt = doc.data()["txt"] as? String{
                            print("et dokument: \(txt)")
                            let note = Note()
                            note.txt = txt
                            note.id = doc.documentID
                            self.notes.append(note)
                        }
                    }
                }
            }
        }
    }
    
}

