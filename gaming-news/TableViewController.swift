//
//  TableViewController.swift
//  gaming-news
//
//  Created by abdulahi roble on 22/09/2021.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {

    
    private var fb = Firestore.firestore()
    var notes:[Note] = []
    var currentNote = -1
    override func viewDidLoad() {
        super.viewDidLoad()
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

        cell.textLabel?.text = notes[indexPath.row].txt

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            deleteNote(index: indexPath.row)
//            notes.remove(at: indexPath.row) // need to delete here also, because FB is "slow"
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    
    
    
    func deleteNote(index:Int) {
        fb.collection("notes").document(notes[index].id).delete()
    }

    func simpleDelete(){
        fb.collection("notes").document("mgAUSd4Pg0pZV9iMufkm").delete()
    }
    
    func simpleEdit(){
        var data=[String:String]()
        data["txt"] = "a new note here"
        fb.collection("notes").document("mgAUSd4Pg0pZV9iMufkm").setData(data)
    }

    
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
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    
    func insertData(txt:String){
        let document = fb.collection("notes").document()
        var data = [String:String]()
        data["txt"] = txt
        // put more if you like...
        document.setData(data)
    }
    
    
    func startListener(){
        fb.collection("notes").addSnapshotListener {(snap, error) in
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
                            // self = this i java
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    
    @IBAction func addNotePressed(_ sender: UIButton) {
        let doc = fb.collection("notes").document() // new document with new ID
        var data = [String:String]()
        data["txt"] = "Empty note"
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
        let doc = fb.collection("notes").document(note.id)
        var data = [String:String]()
        data["txt"] = note.txt
//        data["body"] = "body text Jon"
        doc.setData(data)
    }

}
