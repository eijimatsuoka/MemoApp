
import UIKit
 
class MemoTableViewController: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    var memos = [String]()
    
    override func viewDidLoad() {
    super.viewDidLoad()
     
     if self.userDefaults.object(forKey: "memos") != nil {
               self.memos = self.userDefaults.stringArray(forKey: "memos")!
           } else {
               self.memos = ["テスト1", "テスト2", "テスト3"]
           }
    }
                
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue) {
        guard let sourceVC = sender.source as? MemoViewController,
            let memo = sourceVC.memo else {
                return
        }
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.memos[selectedIndexPath.row] = memo
        } else {
            self.memos.append(memo)
        }
        
        self.userDefaults.set(self.memos, forKey: "memos")
        self.tableView.reloadData()
        }
    
    // MARK: - Table view data source
 
override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1//これ変更
}
 
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return self.memos.count//これ変更
}
 
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath)
        cell.textLabel?.text = self.memos[indexPath.row]
        return cell
    }
    
override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "section-\(section)"
}
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.memos.remove(at: indexPath.row)
            self.userDefaults.set(self.memos, forKey: "memos")
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "editMemo" {
            let memoVC = segue.destination as! MemoViewController
            memoVC.memo = self.memos[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }

 
}
