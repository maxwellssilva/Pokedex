//
//  ViewController.swift
//  PokedexToodoo
//
//  Created by user209844 on 13/01/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    let cellsPerRow = 3
        let networkManager = NetworkManager()
        private var pokemons: [Pokemon]?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            networkManager.getData { [weak self] (pokemons) in
                self?.pokemons = pokemons
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
            
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 2
            
            let marginsAndInsets = layout.sectionInset.left + layout.sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + layout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
            
            let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
            
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            layout.sectionInset = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
            layout.itemSize = CGSize(width: 110, height: 140 )
            layout.estimatedItemSize = .zero
            
            collectionView.showsVerticalScrollIndicator = false
            collectionView.collectionViewLayout = layout
            collectionView.contentInsetAdjustmentBehavior = .always
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib.init(nibName: "PokeCell", bundle: nil), forCellWithReuseIdentifier: "PokeCell")
            searchBar.delegate = self
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            pokemons?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell else {
                fatalError("Issue dequeuing cell")
            }
            cell.configure(with: pokemons?[indexPath.row] ?? Pokemon(id: 0, nome: "", tipo: [], peso: 0, altura: 0, habilidades: [], estatisticas: [], linkImg: ""))
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenWidth = super.view.bounds.size.width/100
            return CGSize(width: screenWidth, height: screenWidth)
        }
    
    }
