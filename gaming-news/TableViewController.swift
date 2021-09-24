//
//  TableViewController.swift
//  gaming-news
//
//  Created by abdulahi roble on 22/09/2021.
//

import UIKit
import Firebase

var firebaseService = FirebaseService()
class TableViewController: UITableViewController {

    
    private var fb = Firestore.firestore()
    var notes:[Note] = []
    var comments:[Comment] = []
    var currentNote = -1
    var currentComment = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // firebaseService.startListener()
        firebaseService.parentTVC = self
        
        startListener()
        //simpleDelete()
        //simpleEdit()
       // insertData(txt: "Hej fra Swift")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = notes[indexPath.row].title
        // cell.textLabel?.text = comments[indexPath.row].fortnitecomment

        return cell
    }
    
    /*
    
    func deleteNote(index:Int) {
        fb.collection("games").document(notes[index].id).delete()
    }

    func simpleDelete(){
        fb.collection("games").document("mgAUSd4Pg0pZV9iMufkm").delete()
    }
    
    
    */
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segue1" {
            if let dest = segue.destination as? ViewController {
                dest.parentViewCon = self
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentNote = indexPath.row
        currentComment = indexPath.row
        performSegue(withIdentifier: "segue1", sender: self)
    }


    func startListener(){
        fb.collection("games").addSnapshotListener {(snap, error) in
            if let e = error {
                print("error fetching games \(e)")
            }else {
                if let s = snap{
                    self.notes.removeAll() // clear array first
                    for doc in s.documents{
                        
                        if let txt = doc.data()["title"] as? String{
                            let note = Note()
                            note.title = txt
                            // note.news = txt
                            note.id = doc.documentID
                            self.notes.append(note)
                        }
                        

                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
 

    
    
    
    
    
    @IBAction func addNotePressed(_ sender: UIButton) {
        let doc = fb.collection("games").document() // new document with new ID
        var data = [String:String]()
        data["title"] = "Empty game"
        doc.setData(data)
    }

    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // add code, which deletes the row, both from the GUI
            // and any other place where the data is stored.
        }
    }
    
    func updateNote(note:Note) {
        let doc = fb.collection("games").document(note.id)
        var data = [String:String]()
        data["title"] = note.title
//        data["body"] = "body text Jon"
        doc.setData(data, merge: true)
    }
    
    func insertData(note:Note) {
        let document = fb.collection("games").document()
        var data = [String:String]()
        data["title"] = note.title
        // put more if you like...
        document.setData(data)
    }
    
    func insertCommentData(comment:Comment) {
        let document = fb.collection("comments").document()
        var data = [String:String]()
        data["fortnitecomment"] = comment.fortnitecomment
        // put more if you like...
        document.setData(data)
    }
    
    func simpleEdit(note:Note){
        var data=[String:String]()
        data["title"] = note.title
        fb.collection("games").document("NeOSh4wW5fgdGznzEtVW").setData(data, merge: true)
    }

}
