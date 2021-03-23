//
//  SSPageViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 相对于，我们使用UIScrollView的优点。可以让系统进行控制。而且，支持两种样式。
 1、使用ScrollerView添加viewcontroller.view的使用，需要给view设置frame。
 2、PageController是不需要的。
 
 
 */
class SSPageViewController: UIViewController {

    private let cellId = "cellId"
    
    private var currentIndex: Int = 0
    private weak var pageVc: UIPageViewController!
    private weak var collectionV: UICollectionView!
    
    private var pageChildVcs: Array<PageChildVC> = {
        var ary = [PageChildVC]()
        for index in 0..<10 {
            let vc = PageChildVC(value: "这是第\(index)个")
            ary.append(vc)
        }
        return ary
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.white
        
        let collectionVLayout = UICollectionViewFlowLayout()
        collectionVLayout.itemSize = CGSize(width: 100, height: 50)
        collectionVLayout.minimumLineSpacing = 1
        collectionVLayout.scrollDirection = .horizontal
        let collectionVc = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionVLayout)
        self.collectionV = collectionVc
        collectionVc.backgroundColor = UIColor.blue
        collectionVc.delegate = self
        collectionVc.dataSource = self
        collectionVc.showsHorizontalScrollIndicator = false
        collectionVc.register(SSPageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionVc)
        collectionVc.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        
        let pageVc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageVc = pageVc
        pageVc.delegate = self
        pageVc.dataSource = self
        // 设置要显示的ViewController。
        pageVc.setViewControllers([pageChildVcs[currentIndex]], direction: .forward, animated: true, completion: nil)
        self.addChild(pageVc)
        view.addSubview(pageVc.view)
        pageVc.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(collectionVc.snp.bottom)
        }
        
        
    }

}

extension SSPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageChildVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SSPageCollectionViewCell
        cell.lab.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > currentIndex {
            pageVc.setViewControllers([pageChildVcs[indexPath.row]], direction: .forward, animated: true, completion: nil)
        }else if indexPath.row == currentIndex {
            return
        }else {
            pageVc.setViewControllers([pageChildVcs[indexPath.row]], direction: .reverse, animated: true, completion: nil)
        }
        
        // 移动。动画
        currentIndex = indexPath.row
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
   
}

extension SSPageViewController: UIPageViewControllerDelegate , UIPageViewControllerDataSource{
    
    // 上一个。如果是第一个，返回nil
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
    
    
        print("上一个")
        var currentIndex = pageChildVcs.firstIndex(of: viewController as! PageChildVC)!
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        print("上一个", currentIndex)
        return pageChildVcs[currentIndex]
    }
    
    // 下一个。如果是最后一个，返回nil
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currentIndex = pageChildVcs.firstIndex(of: viewController as! PageChildVC)!
        if currentIndex == pageChildVcs.count - 1 {
            return nil
        }
        currentIndex += 1
        print("下一个", currentIndex)
        return pageChildVcs[currentIndex]
    }
    
    // 准备滑动
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print(pendingViewControllers)
        let currentVc = pendingViewControllers.first as! PageChildVC
        currentIndex = pageChildVcs.firstIndex(of: currentVc)!
    }
    
    // 滑动结束
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        collectionV.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    

    

    
}
