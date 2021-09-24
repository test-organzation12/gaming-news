//
//  FirebaseService.swift
//  FirebaseNotePrep
//
//  Created by Jon Eikholm on 23/09/2021.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseService{
    
    private var fb = Firestore.firestore() // for data
    let storage = Storage.storage() // for files
    
    var notes:[Note] = []
    
    var parentTVC:TableViewController?
    
    func downloadImage(fileName:String, caller:ViewController){
        let imageRef = storage.reference(withPath: fileName)
        imageRef.getData(maxSize: 5000000) { data, error in
            if error == nil {
                print("Download OK")
                let image = UIImage(data: data!)
                caller.imageView.image = image
                // how to get from here to ViewController's imageView?
            }else {
                print("Download not OK")
            }
        }
    }
    
    func uploadImage(filename:String, image:UIImage){
        let data = image.jpegData(compressionQuality: 1.0)!
        let imageRef = storage.reference().child(filename)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        imageRef.putData(data, metadata: metaData) { meta, error in
            if error == nil {
                print("UPload OK")
            }else {
                print("upload not OK")
            }
        }
    }
    
    func insertData(txt:String){
        let document = fb.collection("notes").document()
        var data = [String:String]()
        data["txt"] = txt
        // put more if you like...
        document.setData(data)
    }
    
    func startListener(){
        fb.collection("games").addSnapshotListener {(snap, error) in
            if let e = error {
                print("error fetching notes \(e)")
            }else {
                if let s = snap{
                    self.notes.removeAll() // clear array first
                    for doc in s.documents{
                        if let txt = doc.data()["title"] as? String{
                            print("et dokument: \(txt)")
                            let note = Note()
                            note.title = txt
                            note.id = doc.documentID
                            self.notes.append(note)
                            // self = this i java
                        }
                    }
                    self.parentTVC?.tableView.reloadData()
                }
            }
        }
    }
    
    
}
