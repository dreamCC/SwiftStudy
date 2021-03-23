//
//  SSCollectionViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSCollectionViewController: UIViewController {

    private let kCellId = "SSCollectionViewCell"
    private let kheaderReusableId = "kheaderReusableId"
    private let kfooterReusableId = "kfooterReusableId"

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let collectionFrameLayout = UICollectionViewFlowLayout()
        collectionFrameLayout.minimumLineSpacing = 1
        collectionFrameLayout.minimumInteritemSpacing = 10
        collectionFrameLayout.itemSize = CGSize(width: 100, height: 200)
        collectionFrameLayout.headerReferenceSize = CGSize(width: 0, height: 40)
        collectionFrameLayout.footerReferenceSize = CGSize(width: 0, height: 40)
        let collectionVc = UICollectionView(frame: view.bounds, collectionViewLayout: collectionFrameLayout)
        collectionVc.delegate = self
        collectionVc.dataSource = self
        view.addSubview(collectionVc)
        collectionVc.register(SSCollectionViewCell.self, forCellWithReuseIdentifier: kCellId)
        collectionVc.register(SSCollectionReusableViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kheaderReusableId)
        collectionVc.register(SSCollectionReusableViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: kfooterReusableId)
    }

}

extension SSCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath) as! SSCollectionViewCell
        cell.value = String(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kheaderReusableId, for: indexPath) as! SSCollectionReusableViewHeader
            header.value = "section头部\(indexPath.section)"
            return header
            
        }else {
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: kfooterReusableId, for: indexPath) as! SSCollectionReusableViewFooter
            footer.value = "section尾部\( indexPath.row)"
            return footer
        }
    }
    
    

    
}



