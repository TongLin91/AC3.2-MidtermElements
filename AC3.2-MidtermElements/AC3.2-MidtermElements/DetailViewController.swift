//
//  DetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Tong Lin on 12/8/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var element: Element?
    
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var weigthLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var densityLabel: UILabel!
    @IBOutlet weak var discovery_yearLabel: UILabel!
    @IBOutlet weak var electronsLabel: UILabel!
    @IBOutlet weak var ion_energyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.element?.name
        loadData()
    }
    
    func loadData() {
        if let info = element{
            APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(info.symbol).png") { (data) in
                if let imageData = data{
                    DispatchQueue.main.async {
                        self.largeImage.image = UIImage(data: imageData)
                        self.view.setNeedsLayout()
                    }
                }
            }
            symbolLabel.text = "Symbol: " + info.symbol
            numberLabel.text = "Number: " + String(info.number)
            weightLabel.text = "Weight: " + String(info.weight)
            idLabel.text = String(info.id)
            weigthLabel.text = String(info.weight)
            nameLabel.text = info.name
            meltingLabel.text = "Melting: " + String(info.melting_c ?? 0)
            boilingLabel.text = "Boiling: " + String(info.boiling_c ?? 0)
            densityLabel.text = "Density: " + String(info.density ?? 0)
            discovery_yearLabel.text = "Discovery Year: " + info.discovery_year
            electronsLabel.text = "Electrons: " + (info.electrons ?? "nil")
            ion_energyLabel.text = "Ion_Energy: " + String(info.ion_energy ?? 0)
        }
    }
    
    private func postReady() -> [String: Any]{
        return ["my_name": "Tong",
                "favorite_element": (self.element?.symbol)!]
    }
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        if APIRequestManager.manager.postRequest(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites/", data: postReady()){
            let alert = UIAlertController(title: "Complete", message: "Added to Favorites List", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Error", message: "Added incompete", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK: - Navigation

}
