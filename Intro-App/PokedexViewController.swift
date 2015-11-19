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
    
    struct Pokemon {
        var name: String!
        var image: UIImage!
        var desc: String!
    }
    
    var pokedex = [Pokemon]()
    var current = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPokemon()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showPrevious(sender: AnyObject) {
        current = current > 0 ? current-1 : 0
        updatePokedex(current)
    }
    
    @IBAction func showNext(sender: AnyObject) {
        current = current < self.pokedex.count-1 ? current+1 : current
        updatePokedex(current)
    }
    
    func updatePokedex(index: Int) {
        self.PokeNameLabel.text = self.pokedex[self.current].name!.capitalizedString
        self.PokeMainImage.image = self.pokedex[self.current].image!
    }
    
    func loadPokemon() {
        // Create request
        let url = NSURL(string: "http://okaymon.mybluemix.net/api/pokemon?limit=15")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            let jsonData = data!
            
            do {
                
                // Try parsing JSON
                let jsonObj = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments)
                
                if let dataArray = jsonObj as? NSArray {
                    
                    for index in dataArray {
                        
                        if let dataDic = index as? NSDictionary {
                            
                            let pokeName = dataDic["name"] as? String
                            let pokeDesc = dataDic["description"] as? String
                            var pokeImage: UIImage!
                            
                            if let imageString = dataDic["art_url"] as? String {
                                if let url = NSURL(string: imageString) {
                                    if let data = NSData(contentsOfURL: url) {
                                        pokeImage = UIImage(data: data)
                                    }
                                }
                            }
                            
                            let pokemon = Pokemon(name: pokeName, image: pokeImage, desc: pokeDesc)
                            
                            self.pokedex.append(pokemon)
                            
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.updatePokedex(self.current)
                    })
                }
            }
            catch let error as NSError {
                // Catch fires here, with an NSError being thrown from the JSONObjectWithData method
                print("A JSON parsing error occurred, here are the details:\n \(error)")
            }        }
        
        task.resume()
    }
    
        
}

