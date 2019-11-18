//
//  ViewController.swift
//  Calc
//
//  Created by HT-19R1108 on 2019/11/18.
//  Copyright © 2019 HT-19R1108. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    let labels:[String] = ["AC","+/-","%","÷","7","8","9","×","4","5","6","-","1","2","3","+","0","0",".","="]

    @IBOutlet weak var numbers_Panel: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        numbers_Panel.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20;
   }
       
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Number", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.blue
        
        return cell;
    }
}

