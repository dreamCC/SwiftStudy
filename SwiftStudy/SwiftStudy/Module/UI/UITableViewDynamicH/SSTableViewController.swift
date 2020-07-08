//
//  SSTableViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

struct  SSTableViewModel {
    var name: String
    var isOpen: Bool
}

class SSTableViewController: UIViewController {
    
    private weak var tableV: UITableView!
    private let kHeaderId = "kHeaderId"
    private let kCellId   = "kCellId"
    
    private var dataSource: [SSTableViewModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
    }

    func initSubviews() {
        
        let  dataSourceAry = [ "张三 的想法", "全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。",
                              "李四 的想法", "UIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。",
                              "王五 的想法", "高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                              "QMUI Team 的想法", "全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\nUIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。\n高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                              
                              "张三 的想法1", "全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。",
                              "李四 的想法1", "UIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。",
                              "王五 的想法1", "高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                              "QMUI Team 的想法1", "全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\nUIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。\n高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                              
                              "张三 的想法2", "全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。",
                              "李四 的想法2", "UIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。",
                              "王五 的想法2", "高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                              "QMUI Team 的想法2", "全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\nUIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。\n高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                              
                              "张三 的想法3", "全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。",
                              "李四 的想法3", "UIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。",
                              "王五 的想法3", "高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                              "QMUI Team 的想法3", "全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\nUIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。\n高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。"]
        
        self.dataSource = dataSourceAry.map({ (value) -> SSTableViewModel in
            return SSTableViewModel(name: value, isOpen: true)
        })
        
        
        let tableV = UITableView(frame: CGRect.zero, style: .grouped)
        tableV.delegate   = self
        tableV.dataSource = self
        tableV.contentInsetAdjustmentBehavior = .never
        // self-sizing的是实现方式。
        //tableV.estimatedRowHeight = 44
        //tableV.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableV)
        tableV.register(SSTableViewCell.self, forCellReuseIdentifier: kCellId)
        tableV.register(SSHeaderV.self, forHeaderFooterViewReuseIdentifier: kHeaderId)

    
        self.tableV = tableV
        
        let se = UISearchController()
    
        
    }
    
    
    // 调用的时机比较晚
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        print("viewSafeAreaInsetsDidChange---")
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}

extension SSTableViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath) as! SSTableViewCell
        cell.setModel(model: dataSource[indexPath.row])
        print("---cellForRowAt")
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let cell: SSHeaderV = tableView.dequeueReusableHeaderFooterView(withIdentifier: kHeaderId) as! SSHeaderV
//        cell.nameLab.text = "这是头部-\(section)"
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("---heightForRowAt")

        return tableView.qmui_heightForCell(withIdentifier: kCellId, cacheBy: indexPath) { (cell) in
            let convertCell = cell as! SSTableViewCell
            convertCell.setModel(model: self.dataSource[indexPath.row])
        }
    }
    
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let cell: SSHeaderV = tableView.dequeueReusableHeaderFooterView(withIdentifier: kHeaderId) as! SSHeaderV
//        cell.nameLab.text = "这是尾部-\(section)"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 40
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        dataSource[indexPath.row].isOpen = !dataSource[indexPath.row].isOpen
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    
}
