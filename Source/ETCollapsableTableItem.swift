//
//  ETCollapsableTableItem.swift
//  ETCollapsableTable
//
//  Created by Eugene Trapeznikov on 9/2/16.
//  Copyright © 2016 Evgenii Trapeznikov. All rights reserved.
//

import Foundation

open class ETCollapsableTableItem {

	open var title: String = ""
	open var isOpen: Bool = false
	open var items: [ETCollapsableTableItem] = []

	//MARK: - init
	public init() {
	}

	public init(title: String) {
		self.title = title
	}
}

func ==(left: ETCollapsableTableItem, right: ETCollapsableTableItem) -> Bool {
	return left.title == right.title && left.isOpen == right.isOpen && left.items.count == right.items.count
}
