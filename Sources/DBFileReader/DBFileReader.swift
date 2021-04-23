//
//  DBFileReader.swift
//
//  Created by Jeff Cooper on 12/24/20.
//  Copyright © 2020 Jeff Cooper. All rights reserved.
//

import Foundation

// this class reads a db file, commonly a CSV or a TSV and outputs the data as arrays

public class DBFileReader {

    public var dbFileData: [[String]]? {
        return _dbFileData
    }
    private var _dbFileData: [[String]]? = nil

    public init(localURL: URL) {
        _dbFileData = createDataFromFile(localFileURL: localURL)
    }

    public convenience init?(localFilename: String) {
        if let localFile = Bundle.main.url(forResource: localFilename, withExtension: ""){
            self.init(localURL: localFile)
        } else {
            return nil
        }
    }

    private func createDataFromFile(localFileURL: URL) ->  [[String]]? {
        guard let stringData = try? String(contentsOf: localFileURL, encoding: .ascii) else { return nil }
        if localFileURL.pathExtension == "csv" {
            return csvFrom(data: stringData)
        } else if localFileURL.pathExtension == "tsv" {
            return csvFrom(data: stringData, columnSeparator: "\t")
        }
        return nil
    }

    private func csvFrom(data: String,
                    rowSeparator: String = "\r\n",
                    columnSeparator: String = ",") -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: rowSeparator)
        for row in rows {
            let columns = row.components(separatedBy: columnSeparator)
            if columns.filter({ $0.isEmpty }).count != columns.count { //are all columns NOT empty?
                result.append(columns)
            }
        }
        return result
    }
}
