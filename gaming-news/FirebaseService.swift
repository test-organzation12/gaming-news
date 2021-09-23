//
//  FirebaseService.swift
//  ImagePrep
//
//  Created by Thomas West on 23/08/2021.
//

import UIKit
import FirebaseStorage
import Firebase
class FirebaseService{
    let storage = Storage.storage()
    var storageRef:StorageReference?
    private var db = Firestore.firestore()
    func testUpload() {
        if let img = UIImage(named: "csgo.jpg"){
            uploadImage(image: img, name: "csgo.jpg")
        }
    }
    
    
    func testDownload(){
        downloadImage(path: "csgo.jpg")
    }
    
    
    func uploadImage(image:UIImage, name:String) {
        
            let data = image.jpegData(compressionQuality: 1.0)!
            // Create file metadata to update
            let newMetadata = StorageMetadata()
            newMetadata.contentType = "image/jpeg";
        let imageRef = storage.reference().child("csgo.jpg")
            print("about to putData")
            imageRef.putData(data, metadata: newMetadata) { (metadata, error) in
                if error != nil {
                    print("error putting data \(error.debugDescription)")
                }else {
                    print("Success putting data")
                }
            }
    }
    
    
    
    func downloadImage(path:String) {  // was note:Note
        let imageRef = storage.reference(withPath:path)
        
        imageRef.getData(maxSize: 5000000, completion: { (data, error) in
            if error != nil {
                print("failed to download \(error.debugDescription)")
            }else {
                print("success in downloading image")
                let image = UIImage(data: data!)
                //note.image = image
                print("success in downloading image \(image?.debugDescription)")
            }
        })
    }
    
    
}
