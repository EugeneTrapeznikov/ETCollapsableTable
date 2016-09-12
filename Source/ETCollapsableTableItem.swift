//
//  ETCollapsableTableItem.swift
//  ETCollapsableTable
//
//  Created by Eugene Trapeznikov on 9/2/16.
//  Copyright © 2016 Evgenii Trapeznikov. All rights reserved.
//

import Foundation

public class ETCollapsableTableItem {

	var title: String = ""
	var isVisible: Bool = false
	var isSelected: Bool = false
	var items: [ETCollapsableTableItem] = []

	init(title: String) {
		self.title = title
	}
}

func ==(left: ETCollapsableTableItem, right: ETCollapsableTableItem) -> Bool {
	return left.title == right.title && left.isVisible == right.isVisible && left.isSelected == right.isSelected && left.items.count == right.items.count
}