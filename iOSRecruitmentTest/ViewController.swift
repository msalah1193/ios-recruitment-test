//
//  ViewController.swift
//  iOSRecruitmentTest
//
//  Created by Bazyli Zygan on 15.06.2016.
//  Copyright © 2016 Snowdog. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    //MARK:- IBOutlet(s)
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Variable(s)
    var viewModel: ViewModel?
    private let refreshControl = UIRefreshControl()
    
    
    //MARK:- init(s)
    required init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- life cycle method(s)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        
        //Get data
        viewModel!.getItems { errorString in
            guard let _ = errorString else {
                self.tableView.reloadData()
                return
            }
        }
    }

    //MARK:- Getting Data
    @objc func reloadData(){
        viewModel!.getFromServer { errorString in
            guard let _ = errorString else {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
                return
            }
        }
    }
    

    // MARK: - UITableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        cell.item = viewModel!.items[indexPath.row]
        
        return cell
    }
    
}
