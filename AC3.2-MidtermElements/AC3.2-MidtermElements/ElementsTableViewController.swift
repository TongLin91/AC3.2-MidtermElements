//
//  ElementsTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Tong Lin on 12/8/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit

class ElementsTableViewController: UITableViewController {

    let endpoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"
    var elements: [Element] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Elements"
        loadData()
        self.refreshControl?.addTarget(self, action: #selector(refreshRequested(_:)), for: .valueChanged)
    }
    
    func loadData(){
        APIRequestManager.manager.getData(endPoint: self.endpoint) { (data) in
            if let validData = data{
                DispatchQueue.main.async {
                    if let allElem = Element.setElements(from: validData){
                        self.elements = allElem
                        print(allElem.count)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func refreshRequested(_ sender: UIRefreshControl) {
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let select = self.elements[indexPath.row]
        cell.textLabel?.text = select.name
        cell.detailTextLabel?.text = "\(select.symbol)(\(select.number)) \(select.weight)"

        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(select.symbol)_200.png"){
            (data) in
            if let imageData = data{
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: imageData)
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? DetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            dvc.element = self.elements[indexPath.row]
        }
    }
}
