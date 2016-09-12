//
//  ETCollapsableTableItem.swift
//  ETCollapsableTable
//
//  Created by Eugene Trapeznikov on 9/2/16.
//  Copyright © 2016 Evgenii Trapeznikov. All rights reserved.
//

import Foundation

public class ETCollapsableTableItem {

	public var title: String = ""
	public var isOpen: Bool = false
	public var items: [ETCollapsableTableItem] = []

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