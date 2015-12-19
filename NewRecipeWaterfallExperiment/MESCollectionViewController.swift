//
//  ViewController.swift
//  NewRecipeWaterfallExperiment
//
//  Created by Hok Shun Poon on 19/12/2015.
//  Copyright © 2015 Hok Shun Poon. All rights reserved.
//

import UIKit
import JSQDataSourcesKit
import SelfSizingWaterfallCollectionViewLayout

class MESCollectionViewController: UICollectionViewController {
    
    typealias CellFactory = CollectionViewCellFactory<MESCollectionViewCell, Int>
    typealias HeaderViewFactory = TitledCollectionReusableViewFactory<Int>
    typealias Section = CollectionViewSection<Int>
    
    var dataSourceProvider: CollectionViewDataSourceProvider<Section, CellFactory, HeaderViewFactory>!
    var randomHeights: [Int]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -1. set up a model of random heights!
        randomHeights = (1...30).map{_ in Int(300 + arc4random_uniform(600)) } // 300..900
        
        // 0. set up the number of columns in SelfSizing etc.etc.
        let layout = collectionView!.collectionViewLayout as! SelfSizingWaterfallCollectionViewLayout
        layout.numberOfColumns = 3
        
        // 1. register cells
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: "ruid_cell")
        
        // 2. create sections with your model objects
        let section0 = CollectionViewSection(randomHeights)
        
        // 3. create cell factory
        let factory = CollectionViewCellFactory<MESCollectionViewCell, String>(reuseIdentifier: "ruid_cell") { [unowned self] (cell, model, collectionView, indexPath) in
            cell.height = self.randomHeights[indexPath.item]
            return cell
        }
        
        // 4. create data source provider
        dataSourceProvider = CollectionViewDataSourceProvider(sections: [section0], cellFactory: factory)
        
        // 5. set the table view's data source
        collectionView!.dataSource = dataSourceProvider!.dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.view = nil;
    }

}

