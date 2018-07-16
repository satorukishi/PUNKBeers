//
//  BeerViewController.swift
//  RM43057
//
//  Created by Satoru Kishi on 09/07/2018.
//  Copyright © 2018 Satoru Kishi. All rights reserved.
//
import UIKit

class BeerViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbTagline: UILabel!
    @IBOutlet weak var lbDescricao: UILabel!
    @IBOutlet weak var lbTeorAlcoolico: UILabel!
    @IBOutlet weak var lbEscalaAmargor: UILabel!
    @IBOutlet weak var ivCerveja: UIImageView!
    
    var beer: Beer!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbNome.text = beer.name
        lbTagline.text = beer.tagline
        lbDescricao.text = beer.description
        
        let teor = beer.abv == nil ? "0.0" : String(describing: beer.abv!)
        let escalaAmargor = beer.ibu == nil ? "0.0" : String(describing: beer.ibu!)
        lbTeorAlcoolico.text = teor
        lbEscalaAmargor.text = escalaAmargor
        
        let url = URL(string: beer.image_url)!
        ivCerveja.kf.setImage(with: url)
    }
    
}
