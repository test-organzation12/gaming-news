//
//  TableViewController.swift
//  gaming-news
//
//  Created by Thomas West on 21/09/2021.
//

import UIKit
import Firebase


class TableViewController: UITableViewController {

    @IBOutlet var MyTableViewController: UITableView!
    
    var fb = Firestore.firestore() // gives us the firestore object
    let notes = "notes"

    override func viewDidLoad() {
        super.viewDidLoad()
        startListener()
        simpleEdit()

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
        return 0
    }
    
    
    func startListener() {
        fb.collection(notes).addSnapshotListener { snapshot, error in print("hi from database...")
            
            if let e = error {
                print("some error \(e)")
            }else{
                if let docs = snapshot {
                    for doc in docs.documents {
                        if let txt = doc.data()["txt"] as? String {
                        print("et dokument: \(txt)")
                }
            }
                self.tableView.reloadData()
                }
            }
        }
    }
    
    func inserData(txt:String) {
        let document = fb.collection("notes").document()
        var data = [String:String]()
        data["txt"] = txt
        document.setData(data)
        
    }
    
    func simpleDelete() {
        fb.collection("notes").document("gre11OGjDGNovweaZNOO").delete()
    }
    

    func simpleEdit() {
        var data = [String:String]()
        data["txt"] = "a new note here"
        fb.collection("notes").document("gre11OGjDGNovweaZNOO").setData(data)
    }

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
