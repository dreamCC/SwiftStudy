//
//  SSMJRefreshViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import MJRefresh

class SSMJRefreshViewController: UITableViewController {

    private let dataSources: [String] = {
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
        return dataSourceAry
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
        if #available(iOS 14.0, *) {
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(rightButtonItemClick))
            navigationItem.rightBarButtonItem = barButtonItem
        } else {
            // Fallback on earlier versions
        }
        
        tableView.estimatedRowHeight = 10
        tableView.register(SSItemCell.self, forCellReuseIdentifier: "kCellId")
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            print("开始刷新")
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 5) {
                DispatchQueue.main.async {
                    self.tableView.mj_header?.endRefreshing()
                }
            }
        })
        tableView.mj_header?.backgroundColor = UIColor.red
        
        
    }
    
    @objc func rightButtonItemClick() {
        print(tableView.contentInset, tableView.contentOffset);
    }
    
}

extension SSMJRefreshViewController {
    

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(tableView.contentOffset, tableView.contentInset)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kCellId", for: indexPath) as! SSItemCell
        cell.value = dataSources[indexPath.row]
        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return tableView.qmui_heightForCell(withIdentifier: "kCellId", cacheBy: indexPath) { (cell) in
            let itemCell = cell as! SSItemCell
            itemCell.value = self.dataSources[indexPath.row]
        }
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        for item in tableView.subviews {
            print(item)
        }
    }
}


class SSItemCell: UITableViewCell {
    
    
    var value: String {
        set {
            lab.text = newValue
        }
        get {
            return lab.text ?? ""
        }
    }
    
    
    private let lab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        return lab
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lab)
        
        let title = UILabel()
        title.text = "这是标题"
        title.backgroundColor = UIColor.qmui_random()
        contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(30)
        }

        lab.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(10)
        }
        
        
    
    }
    
   
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        self.lab.preferredMaxLayoutWidth = UIScreen.main.bounds.width
        
        let size = self.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        print(size)
        return size
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
