//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {
// MARK: - Property
    var businesses: [Business]!
    var searchBar: UISearchBar!
    //const
    let colorDefault = UIColor.redColor()
    
    //Outlet
    @IBOutlet weak var tbvBusiness: UITableView!
    
    //contrain

// MARK: - Loop life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorDefault
        
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = colorDefault
        customBarbutton()
        
        self.tbvBusiness.tableFooterView = UIView()
        tbvBusiness.estimatedRowHeight = 90.0
        tbvBusiness.rowHeight = UITableViewAutomaticDimension
        
        searchBar = UISearchBar()
        searchBar.backgroundColor = UIColor.clearColor()
        self.navigationItem.titleView = searchBar
        searchBar.placeholder = "Restaurants"
        
//        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//            self.tbvBusiness.reloadData()
//        })

        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
             self.tbvBusiness.reloadData()
        }        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: - Private Method
    func customBarbutton() {
        let useButton = UIButton(type: UIButtonType.Custom)
        useButton.setTitle("Filter", forState: UIControlState.Normal)
        useButton.frame = CGRectMake(5, 5, 50, 30);
        useButton.layer.masksToBounds = false;
        useButton.layer.cornerRadius = 5;
        useButton.layer.borderWidth = 0.3
        useButton.layer.borderColor = UIColor.whiteColor().CGColor
        useButton.layer.shadowOffset = CGSizeMake(1.5, 1.5);
        useButton.layer.shadowRadius = 0.5;
        useButton.layer.shadowOpacity = 0.5;
        useButton.layer.shadowColor = UIColor.whiteColor().CGColor
        useButton.backgroundColor = colorDefault
        useButton.addTarget(self, action: "leftBarButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        let useItem = UIBarButtonItem(customView: useButton)
        self.navigationItem.leftBarButtonItem = useItem
    }
    
    func leftBarButtonAction(){
        let filterViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewControllerWithIdentifier("FilterViewController") as! FilterViewController
        filterViewController.delegate = self;
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }

    

}

//MARK: - ExtensionTableView
extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource{
    //tableViewDatasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(businesses == nil){
        return 0
        }
        return businesses.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }

    //tableViewDelegate
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        // Remove seperator inset
        if  cell.respondsToSelector("separatorInset"){
            cell.separatorInset = UIEdgeInsetsZero
        }
        // Explictly set your cell's layout margins
        if cell.respondsToSelector("layoutMargins"){
            cell.layoutMargins = UIEdgeInsetsZero
            
        }
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.respondsToSelector("preservesSuperviewLayoutMargins"){
            cell.preservesSuperviewLayoutMargins = false
        }
    }

}

//MARK: - ExtensionFilter Delegate
extension BusinessesViewController: FilterDelegate{
    func filterViewController(offeringModel:OfferingModel, distanceModel: DistanceModel, sortby: SortByModel, categorys: [String: AnyObject]){
        let categories = categorys["categories"] as? [String]
        Business.searchWithTerm("Restaurants", sort: sortby.mode, categories: categories, deals: offeringModel.onSwitch) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tbvBusiness.reloadData()
        }
    }
}
