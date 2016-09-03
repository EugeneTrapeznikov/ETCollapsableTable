//
//  ETCollapsableTable.swift
//  ETCollapsableTable
//
//  Created by Eugene Trapeznikov on 9/2/16.
//  Copyright © 2016 Evgenii Trapeznikov. All rights reserved.
//

import Foundation
import UIKit

class ETCollapsableTable: UIViewController, UITableViewDelegate {
	private var items : [ETCollapsableTableItem] = []

	override func viewDidLoad() {
		super.viewDidLoad()

		items = buildItems()
	}

	// MARK: - Public methods

	func buildItems() -> [ETCollapsableTableItem] {
		// override in subclass
		return []
	}

	func singleOpenSelectionOnly() -> Bool {
		// could be overridden, but not necessary
		return true
	}

	func itemAtIndexPath(indexPath: NSIndexPath) -> ETCollapsableTableItem {

		var item = items[indexPath.section]

		if indexPath.row != 0 {
			item = item.items[indexPath.row - 1]
		}

		return item
	}

	// MARK: - Public table view methods

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return items.count
	}

	func numberOfRowsInSection(section: Int) -> Int {
		let item = items[section]

		var count = 0

		if item.isVisible {
			count = item.items.count + 1
		}
		else {
			count = 1
		}

		return count
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		let item = items[indexPath.section]

		if indexPath.row == 0 && item.items.count > 0 {
			toogleMenuForItem(item, inTableView: tableView, atIndexPath: indexPath)
		}
	}

	// MARK: - Private methods

	private func toogleMenuForItem(item: ETCollapsableTableItem, inTableView tableView: UITableView, atIndexPath indexPath: NSIndexPath) {

		let cell = tableView.cellForRowAtIndexPath(indexPath) as! ETCollapsableTableCell

		tableView.beginUpdates()

		var foundOpenUnchosenMenuSection = false

		for (index, sectionItem) in items.enumerate() {
			let isChosenMenuSection = sectionItem == item

			let isVisible = sectionItem.isVisible

			if (isChosenMenuSection && isVisible) {

				sectionItem.isVisible = false

				cell.closeAnimated(true)

				let indexPaths = indexPathsForSection(indexPath.section,
				                                      andItem: sectionItem)

				tableView.deleteRowsAtIndexPaths(indexPaths,
				                                 withRowAnimation: foundOpenUnchosenMenuSection ? .Bottom : .Top)
			}
			else if (!isVisible && isChosenMenuSection) {

				sectionItem.isVisible = true

				cell.openAnimated(true)

				let indexPaths = indexPathsForSection(indexPath.section,
				                                      andItem: sectionItem)

				tableView.insertRowsAtIndexPaths(indexPaths,
				                                 withRowAnimation: foundOpenUnchosenMenuSection ? .Bottom : .Top)
			}
			else if (isVisible && !isChosenMenuSection && singleOpenSelectionOnly()) {

				foundOpenUnchosenMenuSection = true

				sectionItem.isVisible = false

				let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: index)) as! ETCollapsableTableCell

				cell.closeAnimated(true)

				let indexPaths = indexPathsForSection(index,
				                                      andItem: sectionItem)

				tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: indexPath.section > index ? .Top : .Bottom)
			}
		}

		tableView.endUpdates()
	}

	private func indexPathsForSection(section: Int, andItem item: ETCollapsableTableItem) -> [NSIndexPath] {

		var collector: [NSIndexPath] = []

		let count = item.items.count

		for i in 0...count {
			let indexPath = NSIndexPath(forRow: i+1, inSection: section)
			collector.append(indexPath)
		}

		return collector
	}
}