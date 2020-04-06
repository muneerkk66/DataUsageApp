//
//  DataUsageQuarterVC.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 05/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import UIKit
private typealias DataUsageQuarterVCTableViewMethods = DataUsageQuarterVC
private typealias Constants = DataUsageQuarterVC
class DataUsageQuarterVC: BaseVC {
    @IBOutlet var dataUsageQuarterTableView: UITableView!
    var dataUsageVM = DataUsageVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibs()

        // MARK: Eliminate extra separators below UITableView

        dataUsageQuarterTableView.tableFooterView = UIView()
    }

    fileprivate func registerNibs() {
        dataUsageQuarterTableView.register(UINib(nibName: AppConstants.NibNames.datatUsageNib.rawValue, bundle: Bundle.main), forCellReuseIdentifier: AppConstants.TableViewCellIdentifier.datatUsageCellID.rawValue)
    }
}

// MARK: - TableView DataSource and Deelegate

extension DataUsageQuarterVCTableViewMethods: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableViewCellIdentifier.datatUsageCellID.rawValue,
                                                 for: indexPath) as! DataUsageTableViewCell

        let mobileData = (dataUsageVM.selectedDataUsage?.quarter?[indexPath.row])!
        cell.setMobiledataUsageQuarterValue(mobileData)
        return cell
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let count = dataUsageVM.selectedDataUsage?.quarter?.count else {
            return 0
        }
        return count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
}

extension Constants {
    struct Constants {
        static let rowHeight: CGFloat = 60.0
    }
}
