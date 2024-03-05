//
//  OrderDetailsTableViewController.swift
//  E-CommerceApp
//
//  Created by Basma on 28/02/2024.
//

import UIKit

class OrderDetailsTableViewController: UITableViewController {
    
    var result : Order?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OrdersTableViewCell.nib(),forCellReuseIdentifier: "orderCell")
        
    }
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return result?.lineItems.count ?? 0
        }
        
        
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrdersTableViewCell
             cell.orderNum.text = result?.lineItems[indexPath.row].name?.split(separator: "|").dropFirst().first.map(String.init)
             cell.QuantityLabel.text = "Quantity"
             cell.CreatedDate.text = String(result?.lineItems[indexPath.row].quantity ?? 0 )
             cell.totalAmountLabel.text = "Price"
             cell.totalAmount.text = "\(result?.lineItems[indexPath.row].price ?? "") \(result?.currency ?? "")"
         
         return cell
         }
        
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "All Items"
    }
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

