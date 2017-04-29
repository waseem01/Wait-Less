//
//  Table.swift
//  Wait-Less
//
//  Created by Waseem Mohd on 4/27/17.
//  Copyright © 2017 Jonathan Wong. All rights reserved.
//

import UIKit
import Parse

class Table: NSObject {

    var tableNumber: Int?
    var capacity: Int?
    var status: Bool = false

    init(tableData: PFObject) {
        tableNumber = tableData.object(forKey: "tableNumber") as? Int
        capacity = tableData.object(forKey: "capacity") as? Int
        status = tableData.object(forKey: "status") as? Bool ?? false
    }

    convenience override init() {
        self.init(tableData: PFObject.init(className: ""))
    }

    class func tablesArray(array: [PFObject]) -> [Table] {
        var tables = [Table]()
        for table in array {
            print(table)
            tables.append(Table(tableData: table))
        }
        return tables
    }

    func getTables(success: @escaping ([Table]) -> Void, failure: @escaping (Error) -> Void){
        var tables = [Table]()
        let query = PFQuery(className: "Table")
        query.findObjectsInBackground { (pfObjects, error) in
            if (!(error != nil)) {
                tables = Table.tablesArray(array: pfObjects!)
                success(tables)
            } else {
                failure(error!)
            }
        }
    }
}
