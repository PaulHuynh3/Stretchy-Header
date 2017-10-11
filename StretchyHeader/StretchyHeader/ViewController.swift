//
//  ViewController.swift
//  StretchyHeader
//
//  Created by Paul on 2017-10-10.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit

private let kTableHeaderHeight: CGFloat = 300.0
//cut away
private let kTableHeaderCutAway: CGFloat = 80.0

class ViewController: UITableViewController {

    
    var headerView: UIView!
    
    //property to determine which part of our image will be visible
    var headerMaskLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = UITableViewAutomaticDimension
        
        func prefersStatusBarHidden() -> Bool {
        return true
        }
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: kTableHeaderHeight)
        
        //cut away
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        updateHeaderView()
    
        //adjust so it doesnt cut the contents
        let effectiveHeight = kTableHeaderHeight - kTableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        
    }


    
    
    
    let items = [
        
        NewsItem(category: .World, summary: "climate change protests"),
        NewsItem(category: .Europe, summary: "scotland's 'yes' leader"),
        NewsItem(category: .MiddleEast, summary: "airstrike boost islamic"),
        NewsItem(category: .Africa, summary: "this is africa land"),
        NewsItem(category: .AsiaPacific, summary: "this is asia pacific!"),
        NewsItem(category: .Americas, summary: "this is the america we know"),
        NewsItem(category: .World, summary: "back to the world"),
        NewsItem(category: .Europe, summary: "back to europe!")
    ]
    
    
    func updateHeaderView () {
        //adjust so it doesnt cut the contents
        let effectiveHeight = kTableHeaderHeight - kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height:kTableHeaderHeight)
        
        
        if tableView.contentOffset.y < -effectiveHeight {
        headerRect.origin.y = tableView.contentOffset.y
        headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2
        }
        headerView.frame = headerRect
        
        //add cut away
        let path = UIBezierPath ()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - kTableHeaderCutAway))
        headerMaskLayer?.path = path.cgPath
        

        
    
    }
    
    //MARK: scrollview Delegate
    //provides notification of scrollview scrolling
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
    updateHeaderView()
    
    }
    
    
    
    
    //MARK: UITableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    }

    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let item = items[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsItemCell
        
        cell.newsItem = item
        
        
        return cell
        
        
    }
    
    
    

    
    

}

