//
//  ETCollapsableTable.swift
//  ETCollapsableTable
//
//  Created by Eugene Trapeznikov on 9/2/16.
//  Copyright © 2016 Evgenii Trapeznikov. All rights reserved.
//

import Foundation
import UIKit

open class ETCollapsableTable: UIViewController {
	fileprivate var items : [ETCollapsableTableItem] = []

	override open func viewDidLoad() {
		super.viewDidLoad()

		items = buildItems()
	}

	// MARK: - Public methods

	open func buildItems() -> [ETCollapsableTableItem] {
		// override in subclass
		return []
	}

	open func singleOpenSelectionOnly() -> Bool {
		// could be overridden, but not necessary
		return true
	}

	open func itemAtIndexPath(_ indexPath: IndexPath) -> ETCollapsableTableItem {

		var item = items[indexPath.section]

		if indexPath.row != 0 {
			item = item.items[indexPath.row - 1]
		}

		return item
	}

	// MARK: - Public table view methods

	open func numberOfSections() -> Int {
		return items.count
	}

	open func numberOfRowsInSection(_ section: Int) -> Int {
		let item = items[section]

		var count = 0

		if item.isOpen {
			count = item.items.count + 1
		}
		else {
			count = 1
		}

		return count
	}

	open func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {

		let item = items[indexPath.section]

		if indexPath.row == 0 && item.items.count > 0 {
			toogleMenuForItem(item, inTableView: tableView, atIndexPath: indexPath)
		}
	}

	// MARK: - Private methods

	fileprivate func toogleMenuForItem(_ item: ETCollapsableTableItem, inTableView tableView: UITableView, atIndexPath indexPath: IndexPath) {

		let cell = tableView.cellForRow(at: indexPath) as! ETCollapsableTableCell

		tableView.beginUpdates()

		var foundOpenUnchosenMenuSection = false

		for (index, sectionItem) in items.enumerated() {
			let isChosenMenuSection = sectionItem == item

			let isOpen = sectionItem.isOpen

			if (isChosenMenuSection && isOpen) {

				sectionItem.isOpen = false

				cell.closeAnimated(true)

				let indexPaths = indexPathsForSection(indexPath.section,
				                                      andItem: sectionItem)

				tableView.deleteRows(at: indexPaths,
				                                 with: foundOpenUnchosenMenuSection ? .bottom : .top)
			}
			else if (!isOpen && isChosenMenuSection) {

				sectionItem.isOpen = true

				cell.openAnimated(true)

				let indexPaths = indexPathsForSection(indexPath.section,
				                                      andItem: sectionItem)

				tableView.insertRows(at: indexPaths,
				                                 with: foundOpenUnchosenMenuSection ? .bottom : .top)
			}
			else if (isOpen && !isChosenMenuSection && singleOpenSelectionOnly()) {

				foundOpenUnchosenMenuSection = true

				sectionItem.isOpen = false

				let cell = tableView.cellForRow(at: IndexPath(row: 0, section: index)) as! ETCollapsableTableCell

				cell.closeAnimated(true)

				let indexPaths = indexPathsForSection(index,
				                                      andItem: sectionItem)

				tableView.deleteRows(at: indexPaths, with: indexPath.section > index ? .top : .bottom)
			}
		}

		tableView.endUpdates()
	}

	fileprivate func indexPathsForSection(_ section: Int, andItem item: ETCollapsableTableItem) -> [IndexPath] {

		var collector: [IndexPath] = []

		let count = item.items.count

		for i in 1...count {
			let indexPath = IndexPath(row: i, section: section)
			collector.append(indexPath)
		}

		return collector
	}
}
