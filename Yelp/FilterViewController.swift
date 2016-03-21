//
//  FilterViewController.swift
//  Yelp
//
//  Created by nguyen trung quang on 3/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
@objc protocol FilterDelegate {
    optional func filterViewController(offeringModel:OfferingModel, distanceModel: DistanceModel, sortby: SortByModel, categorys: [String: AnyObject])
}
class FilterViewController: UIViewController {
//varar: Property
    var arrCategory: NSArray?
    var arrSortMode: NSArray?
    var arrDistance: NSArray?
    var arrCategoryOr: NSArray?
    var arrSortModeOr: NSArray?
    var arrDistanceOr: NSArray?
    
    var offerModel: OfferingModel?
    var seeAllLabel: UILabel?
    var delegate: FilterDelegate?

    //Outlet
    @IBOutlet weak var tbvFilter: UITableView!
    //contrain
    
// MARK: - Loop life
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvFilter.tableFooterView = UIView()
        
        arrCategoryOr = getCategory()
        arrSortModeOr = getSearchMode()
        arrDistanceOr = getDistance()
        
        tbvFilter.separatorStyle = UITableViewCellSeparatorStyle.None
        self.resetTable()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - BarButtonAction
    @IBAction func cancelAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func searchButtonAction(sender: AnyObject) {
        var distanceModel = DistanceModel!()
        var sortBymodel = SortByModel!()
        for model in arrDistanceOr!{
            if (model as! DistanceModel).isSelect {
                distanceModel = model as! DistanceModel
                break
            }
        }
        for model in arrSortModeOr!{
            if (model as! SortByModel).isSelect {
                sortBymodel = model as! SortByModel
                break
            }
        }
        var filters = [String : AnyObject]()
        var selectCategories = [String]()
        for model in arrCategoryOr!{
            if ((model as! CategoryModel).onSwitch == true){
                selectCategories.append(model.name)
            }
        }
        if selectCategories.count > 0 {
            filters["categories"] = selectCategories
        }
        delegate!.filterViewController!(self.offerModel!, distanceModel: distanceModel, sortby: sortBymodel, categorys: filters)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
// MARK: - PrivateMethod
    
    func selectedDistance(distanceModel: DistanceModel) ->DistanceModel{
        for model in arrDistanceOr!{
            if (model as! DistanceModel).isSelect {
                (model as! DistanceModel).isSelect = false
            }
        }
        distanceModel.isSelect = true
        return distanceModel
    }
    
    func selectedSortBy(sortByModel: SortByModel) ->SortByModel{
        for model in arrSortModeOr!{
            if (model as! SortByModel).isSelect {
                (model as! SortByModel).isSelect = false
            }
        }
        sortByModel.isSelect = true
        return sortByModel
    }
    
    func reloadCategory(){
        if arrCategory?.count == 3 {
            arrCategory = arrCategoryOr
        }else{
            arrCategory = [arrCategoryOr![0], arrCategoryOr![1], arrCategoryOr![2]]
        }
        tbvFilter.reloadSections(NSIndexSet(index: 3), withRowAnimation: UITableViewRowAnimation.None)
    }
    func resetTable(){
        arrCategory = [arrCategoryOr![0], arrCategoryOr![1], arrCategoryOr![2]]
        arrSortMode = [arrSortModeOr![0]]
        arrDistance = [arrDistanceOr![0]]
        offerModel = OfferingModel()
        tbvFilter.reloadData()
    }
    
    func getCategory() ->NSArray{
        let path = NSBundle.mainBundle().pathForResource("category", ofType: "json")
        let data = try! NSData(contentsOfURL: NSURL(fileURLWithPath: path!), options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonObj =  try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray
        let arr =  NSMutableArray()
        for dic in jsonObj {
            arr.addObject(CategoryModel(dic: dic as! NSDictionary))
        }
        return arr
    }
    
    func getSearchMode()->NSArray{
        let  bestMatch = SortByModel(name: "BestMatched", isSelect: true, mode: YelpSortMode.BestMatched)
        let  distance = SortByModel(name: "Distance", isSelect: false, mode: YelpSortMode.Distance)
        let  highestRated = SortByModel(name: "HighestRated", isSelect: false, mode: YelpSortMode.HighestRated)
        return [bestMatch, distance, highestRated]
    }

    func getDistance() -> NSArray{
        let auto = DistanceModel(name: "Auto", isSelect: true, value: 0)
        let o3 = DistanceModel(name: "0.3 miles", isSelect: false, value: 0.3)
        let one = DistanceModel(name: "1 mile", isSelect: false, value: 1)
        let five = DistanceModel(name: "5 miles", isSelect: false, value: 5)
        let twenty = DistanceModel(name: "20 miles", isSelect: false, value: 20)
        return [auto, o3, one, five, twenty]
    }
}

//MARK: - ExtensionTableView
extension FilterViewController : UITableViewDelegate, UITableViewDataSource{
    //tableViewDatasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 4
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if section == 0 {
            return 15
        }else{
            return 50
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        if section == 0 {
            return UITableViewHeaderFooterView()
        }else{
            let header = UITableViewHeaderFooterView()
            if section == 1 {
                header.textLabel?.text = "Distance"
            }else
                if section == 2 {
                    header.textLabel?.text = "Sort By"
                }else
                    if section == 3 {
                        header.textLabel?.text = "Category"
                        let seeAllButton = UIButton(frame: CGRect(x: UIScreen.mainScreen().bounds.size.width - 115, y: 5, width: 100, height: 40))
                        seeAllButton.layer.masksToBounds = false;
                        seeAllButton.layer.cornerRadius = 5;
                        seeAllButton.layer.borderWidth = 0.3
                        seeAllButton.layer.borderColor = UIColor.whiteColor().CGColor
                        seeAllButton.layer.shadowOffset = CGSizeMake(1.5, 1.5);
                        seeAllButton.layer.shadowRadius = 0.5;
                        seeAllButton.layer.shadowOpacity = 0.5;
                        
                        seeAllLabel = UILabel(frame: seeAllButton.frame)
                        seeAllButton.addTarget(self, action: "reloadCategory", forControlEvents: UIControlEvents.TouchUpInside)
                        
                        if arrCategory?.count == 3 {
                            seeAllLabel?.text = "See All"
                            seeAllLabel?.sizeToFit()
                        }else{
                            
                            seeAllLabel?.text = "Hide"
                            seeAllLabel?.sizeToFit()
                        }
                        
                        seeAllLabel?.center = seeAllButton.center
                        header.addSubview(seeAllLabel!)
                        header.addSubview(seeAllButton)
            }
            return header
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return arrCategory?.count ?? 0
        }else if section == 1 {
            return arrDistance?.count ?? 0
        }else if section == 2 {
            return arrSortMode?.count ?? 0
        }else if section == 0{
            return 1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
           let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell") as! SwitchCell
            cell.offer = self.offerModel
            return cell
        }else
            if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("CheckCell") as! CheckCell
                cell.distance = self.arrDistance![indexPath.row] as! DistanceModel
                return cell
                
            }else
                if indexPath.section == 2 {
                    let cell = tableView.dequeueReusableCellWithIdentifier("CheckCell") as! CheckCell
                    cell.sortBy = self.arrSortMode![indexPath.row] as! SortByModel
                    return cell
                }else
                    if indexPath.section == 3 {
                      let  cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell") as! SwitchCell
                        cell.category = self.arrCategory![indexPath.row] as! CategoryModel
                        return cell
        }
        return UITableViewCell()
    }
    //tableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.section == 1 {
            if indexPath.row == 0 && arrDistance?.count == 1 {
                arrDistance = arrDistanceOr
            }else{
                arrDistance = [arrDistanceOr![indexPath.row]]
                selectedDistance(arrDistanceOr![indexPath.row] as! DistanceModel)
            }
            self.tbvFilter.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.None)
        }
        if indexPath.section == 2 {
            if indexPath.row == 0 && arrSortMode?.count == 1 {
                arrSortMode = arrSortModeOr
            }else{
                arrSortMode = [arrSortMode![indexPath.row]]
                selectedSortBy(arrSortModeOr![indexPath.row] as! SortByModel)

            }
            self.tbvFilter.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    
}
