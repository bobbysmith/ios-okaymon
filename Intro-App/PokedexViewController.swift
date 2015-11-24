//
//  PokedexViewController.swift
//  Intro-App
//
//  Created by Gaby Moreno on 11/18/15.
//  Copyright © 2015 Bobby Smith. All rights reserved.
//
import UIKit

class PokedexViewController: UIViewController {
    
    @IBOutlet weak var PokeNameLabel: UILabel!
    @IBOutlet weak var PokeMainImage: UIImageView!
    
    var pokedex = Pokedex()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokedex.loadPokemon(self.updateDisplay)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateDisplay() {
        let pokemon = pokedex.getCurrentPokemon()
        
        if let currentName = pokemon.name {
            self.PokeNameLabel.text = "#\(pokemon.id) \(currentName.capitalizedString)"
        }
        
        if let currentImage = pokemon.image {
            self.PokeMainImage.image = currentImage
        }
    }
    
    @IBAction func showPrevious(sender: AnyObject) {
        var current = pokedex.getCurrent()
        
        current = current > 0 ? current-1 : 0
        
        pokedex.setCurrent(current)
        updateDisplay()
    }
    
    @IBAction func showNext(sender: AnyObject) {
        var current = pokedex.getCurrent()
        
        current = current < pokedex.getSize()-1 ? current+1 : current
        
        pokedex.setCurrent(current)
        updateDisplay()
    }
        
}

