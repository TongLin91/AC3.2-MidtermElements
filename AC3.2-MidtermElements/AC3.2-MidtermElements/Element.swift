//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Tong Lin on 12/8/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import Foundation

class Element {
    /*
     "id": 108,
     "record_url": "https://fieldbook.com/records/5848dead37802c0400b17cd6",
     "number": 108,
     "weight": 277,
     "name": "Hassium",
     "symbol": "Hs",
     "melting_c": null,
     "boiling_c": null,
     "density": null,
     "crust_percent": null,
     "discovery_year": "1984",
     "group": 8,
     "electrons": null,
     "ion_energy": null
     */
    
    let id: Int
    let record_url: String
    let number: Int
    let weight: Double
    let name: String
    let symbol: String
    let melting_c: Int?
    let boiling_c: Int?
    let density: Double?
    let crust_percent: Double?
    let discovery_year: String
    let group: Int
    let electrons: String?
    let ion_energy: Double?
    
    
    init(id: Int, record_url: String, number: Int, weight: Double, name: String, symbol: String, melting_c: Int?, boiling_c: Int?, density: Double?, crust_percent: Double?, discovery_year: String, group: Int, electrons: String?, ion_energy: Double?) {
        self.id = id
        self.record_url = record_url
        self.number = number
        self.weight = weight
        self.name = name
        self.symbol = symbol
        self.melting_c = melting_c
        self.boiling_c = boiling_c
        self.density = density
        self.crust_percent = crust_percent
        self.discovery_year = discovery_year
        self.group = group
        self.electrons = electrons
        self.ion_energy = ion_energy
        
    }
    
    convenience init?(dict: [String: AnyObject]) {
        if let id = dict["id"] as? Int,
            let record_url = dict["record_url"] as? String,
            let number = dict["number"] as? Int,
            let weight = dict["weight"] as? Double,
            let name = dict["name"] as? String,
            let symbol = dict["symbol"] as? String,
            let discovery_year = dict["discovery_year"] as? String,
            let group = dict["group"] as? Int{
            
            let melting_c = dict["melting_c"] as? Int ?? nil
            let boiling_c = dict["boiling_c"] as? Int ?? nil
            let density = dict["density"] as? Double ?? nil
            let crust_percent = dict["crust_percent"] as? Double ?? nil
            let electrons = dict["electrons"] as? String ?? nil
            let ion_energy = dict["ion_energy"] as? Double ?? nil
            
            self.init(id: id, record_url: record_url, number: number, weight: weight, name: name, symbol: symbol, melting_c: melting_c, boiling_c: boiling_c, density: density, crust_percent: crust_percent, discovery_year: discovery_year, group: group, electrons: electrons, ion_energy: ion_energy)
        }else {
            return nil
        }
    }
    
    static func setElements(from data: Data) -> [Element]?{
        var elementArr: [Element]? = []
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [[String : AnyObject]] = jsonData as? [[String : AnyObject]] else {
                    return elementArr
            }
            
            for item in response {
                if let element = Element(dict: item) {
                    elementArr?.append(element)
                }
            }
        }catch {
            print("Unknown parsing error")
        }
        return elementArr
    }
}
