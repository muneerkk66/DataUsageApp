//
//  ViewController.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 03/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import FittedSheets
import UIKit
private typealias DataUsageVCTableViewMethods = DataUsageVC
private typealias Constants = DataUsageVC

class DataUsageVC: BaseVC {
    @IBOutlet var dataUsageLisTableView: UITableView!
    var dataUsageVM = DataUsageVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibs()

        // MARK: - Loading saved data from Coredata

        showLoadedDataUsage()

        // MARK: - Fetch the latest mobile data details from Server using API calls

        loadDataUsage()
    }

    fileprivate func registerNibs() {
        dataUsageLisTableView.register(UINib(nibName: AppConstants.NibNames.datatUsageNib.rawValue, bundle: Bundle.main), forCellReuseIdentifier: AppConstants.TableViewCellIdentifier.datatUsageCellID.rawValue)
        dataUsageLisTableView.accessibilityIdentifier = AppConstants.AccessibilityIdentifier.dataUsagetableView.rawValue
    }

    func loadDataUsage() {
        dataUsageVM.fetchDataUsage { [weak self] (error) -> Void in
            guard let weakSelf = self else {
                return
            }
            if let _ = error {
                weakSelf.showAlert(error?.localizedDescription)
            } else {
                weakSelf.showLoadedDataUsage()
            }
        }
    }

    // MARK: - This will load the Mobile data usage list from Coredata

    func showLoadedDataUsage() {
        dataUsageVM.dataUsageList = dataUsageVM.loadDataUsageList() ?? []
        dataUsageLisTableView.reloadData()
    }

    func navigateQuarterValueVC() {
        let onboardingStoryboard: UIStoryboard = UIStoryboard(name: AppConstants.StoryboardName.main.rawValue, bundle: Bundle.main)
        let quarterVC = onboardingStoryboard.instantiateViewController(withIdentifier: AppConstants.StoryboardIdentifier.quarterVC.rawValue) as! DataUsageQuarterVC
        quarterVC.dataUsageVM = dataUsageVM
        let controller = SheetViewController(controller: quarterVC, sizes: [.fixed(AppConstants.screenHeight / Constants.quarterVCHeightRatio), .fullScreen])
        present(controller, animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource and Deelegate

extension DataUsageVCTableViewMethods: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableViewCellIdentifier.datatUsageCellID.rawValue,
                                                 for: indexPath) as! DataUsageTableViewCell
        let mobileData = dataUsageVM.dataUsageList[indexPath.row]
        cell.setMobiledataUsageValue(mobileData)
        return cell
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataUsageVM.dataUsageList.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mobileData = dataUsageVM.dataUsageList[indexPath.row]

        if mobileData.hasDecremented {
            dataUsageVM.selectedDataUsage = mobileData
            navigateQuarterValueVC()
        }
    }
}

extension Constants {
    struct Constants {
        static let rowHeight: CGFloat = 120.0
        static let quarterVCHeightRatio: CGFloat = 2.5
    }
}
