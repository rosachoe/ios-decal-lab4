//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PokemonInfoViewController {
            dest.pokemon = pokemonArray?[(selectedIndexPath?.row)!]
            if let image = cachedImages[(selectedIndexPath?.row)!] {
                dest.image = image
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray!.count
    }
    
    
    
    //At a given index, what should the cell look like
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "table", for: indexPath) as! tableviewcell
        
        let pokemon = pokemonArray?[indexPath.row]
        cell.name.text = pokemon?.name
        cell.stats.text = "\((pokemon?.attack)!)/\((pokemon?.defense)!)/\((pokemon?.health)!)"
        cell.number.text = "#\((pokemon?.number)!)"
        if let image = cachedImages[indexPath.row] {
            cell.pokemon.image = image // may need to change this!
        } else {
            let url = URL(string: (pokemon?.imageUrl)!)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            cell.pokemon.image = UIImage(data: imageData) // may need to change this!
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "CISegue", sender: self)
    }

    @IBOutlet weak var table: UITableView!
}
