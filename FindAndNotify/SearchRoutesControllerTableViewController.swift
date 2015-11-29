    //
//  SearchRoutesControllerTableViewController.swift
//  FindAndNotify
//
//  Created by Nicole Chung on 2015-11-29.
//  Copyright © 2015 Nicole Chung. All rights reserved.
//

import UIKit

class SearchRoutesControllerTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var routes = [Route]()
    var filteredRoutes = [Route]()
    var resultSearchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        NextBusService.sharedInstance.getRoutes({(routeList)->Void in
            self.routes = routeList;
            print("----routes----")
            print(routeList);
        })
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.active {
            return self.filteredRoutes.count
        } else {
            return self.routes.count;
        }
        
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell?

        // Configure the cell...
        if self.resultSearchController.active {
            cell!.textLabel?.text = self.filteredRoutes[indexPath.row].title
        } else {
            cell!.textLabel?.text = self.routes[indexPath.row].title
        }
        
        cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        return cell!
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filteredRoutes.removeAll(keepCapacity: false)
        
        filterContentForSearchText(searchController.searchBar.text!)
        
        self.tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText:String) {
        self.filteredRoutes = self.routes.filter({(route:Route) -> Bool in
            let stringMatch = route.title.rangeOfString(searchText);
            return stringMatch != nil;
        })
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
