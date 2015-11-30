//
//  Pokedex.swift
//  Intro-App
//
//  Created by Gaby Moreno on 11/24/15.
//  Copyright © 2015 Bobby Smith. All rights reserved.
//

import UIKit

struct Pokemon {
    var id: Int!
    var name: String!
    var image: UIImage!
    var desc: String!
}

class Pokedex {
    
    var pokedex = [Pokemon]()
    var currentIndex = 0
    
    func getCurrent() -> Int {
        return self.currentIndex
    }
    
    func setCurrent(newCurrent: Int) -> Void {
        self.currentIndex = newCurrent
    }
    
    func getCurrentPokemon() -> Pokemon {
        if self.pokedex.count > self.currentIndex {
            return self.pokedex[self.currentIndex]
        } else {
            return Pokemon()
        }
    }
    
    func getCurrentName() -> String {
        if self.pokedex.count > self.currentIndex {
            if let currentName = self.pokedex[self.currentIndex].name {
                return currentName.capitalizedString
            } else {
                return "No name!"
            }
        } else {
            return "Pokedex not ready yet!"
        }
    }
    
    func getCurrentImage() -> UIImage {
        if self.pokedex.count > self.currentIndex {
            if let currentImage = self.pokedex[self.currentIndex].image {
                return currentImage
            } else {
                return UIImage()
            }
        } else {
            return UIImage()
        }
    }
    
    func getSize() -> Int {
        return self.pokedex.count
    }
    
    func loadPokemon(callback: ()->()) {
        // Create request
        let url = NSURL(string: "http://okaymon.mybluemix.net/api/pokemon?limit=10")
        
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
                            let pokeID = dataDic["pkdx_id"] as? Int
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
                            
                            let pokemon = Pokemon(id: pokeID, name: pokeName, image: pokeImage, desc: pokeDesc)
                            
                            self.pokedex.append(pokemon)
                            
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //self.updateDisplay(self.currentIndex)
                        callback()
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
