//
//  BeersTableViewController.swift
//  RM43057
//
//  Created by Satoru Kishi on 09/07/2018.
//  Copyright © 2018 Satoru Kishi. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class BeersTableViewController: UITableViewController {
    
    var beers: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBeers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "beerSegue" {
            let vc = segue.destination as! BeerViewController
            vc.beer = beers[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    func loadBeers() {
        REST.loadBeers(onComplete: { [weak self] (loadedBeers) in
            print("Terminou!!!")
            self?.beers = loadedBeers
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }) { (error) in
            switch error {
            case .responseStatusCode(let code):
                print("Você recebeu o statusCode de código \(code)")
            default:
                print("Deu erro, esta cerveja não desce redondo!")
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return beers.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beer = beers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BeerTableViewCell
        cell.lbNome.text = beer.name
        cell.lbTeorAlcoolico.text = "Teor Alcoólico: " + String(beer.abv)
        
        let url = URL(string: beer.image_url)!
        cell.ivBeer.kf.setImage(with: url)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let beer = beers[indexPath.row]
            REST.deleteBeer(beer, onComplete: { (success) in
                if success {
                    self.beers.remove(at: indexPath.row)
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            })
        }
    }
    
}
