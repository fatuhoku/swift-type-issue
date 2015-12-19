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
    
    typealias CellFactory = CollectionViewCellFactory<MESCollectionViewCell, String>
    typealias HeaderViewFactory = TitledCollectionReusableViewFactory<String>
    typealias Section = CollectionViewSection<String>
    
    var dataSourceProvider: CollectionViewDataSourceProvider<Section, CellFactory, HeaderViewFactory>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0. set up the number of columns in SelfSizing etc.etc.
        let layout = collectionView!.collectionViewLayout as! SelfSizingWaterfallCollectionViewLayout
        layout.numberOfColumns = 3
        
        // 1. register cells
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: "ruid_cell")
        
        // 2. create sections with your model objects
        let section0 = CollectionViewSection<String>(items: "1", "2", "3", "Five", "Six", "Seven")
        let allSections = [section0]
        
        // 3. create cell factory
        let factory = CollectionViewCellFactory<MESCollectionViewCell, String>(reuseIdentifier: "ruid_cell") { (cell, model, collectionView, indexPath) in
            // Do nothing to configure the cell.
            return cell
        }
        
        // 4. create data source provider
        dataSourceProvider = CollectionViewDataSourceProvider(sections: allSections, cellFactory: factory)
        
        // 5. set the table view's data source
        collectionView!.dataSource = dataSourceProvider!.dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.view = nil;
    }

}

