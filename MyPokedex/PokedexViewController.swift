//
//  PokedexViewController.swift
//  MyPokedex
//
//  Created by Gaby Moreno on 11/25/15.
//  Copyright © 2015 Okaypokemon. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    
    var pokedex = Pokedex()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokedex.loadPokemon(self.updateDisplay)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showNext(sender: AnyObject) {
        print("Next")
//        var current = pokedex.getCurrent()
//        
//        current = current < pokedex.getSize()-1 ? current+1 : current
//        
//        pokedex.setCurrent(current)
        self.updateDisplay()
    }
    
    @IBAction func showPrevious(sender: AnyObject) {
        print("Previous")
//        var current = pokedex.getCurrent()
//        
//        current = current > 0 ? current-1 : 0
//        
//        pokedex.setCurrent(current)
        self.updateDisplay()
    }
    
    func updateDisplay() {
        print("Finished loading")
    }
    
}
