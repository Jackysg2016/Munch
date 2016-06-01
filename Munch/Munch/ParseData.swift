//
//  ParseData.swift
//  Munch
//
//  Created by Taylor Benna on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

import Foundation
import CoreData

@objc class ParseData : NSObject {
    
    func parseData(context: NSManagedObjectContext?) {
        // Load the CSV file and parse it
        let filePath = NSBundle.mainBundle().pathForResource("Food Cats - Sheet1", ofType: "csv")
        let contentData = NSFileManager.defaultManager().contentsAtPath(filePath!)
        
        let delimiter = ","
        var items:[(name:String, detail:String)]?
        
        let content = NSString(data: contentData!, encoding: NSUTF8StringEncoding) as! String
        items = []
        let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
        
        for line in lines {
            var values:[String] = []
            if line != "" {
                // For a line with double quotes
                // we use NSScanner to perform the parsing
                if line.rangeOfString("\"") != nil {
                    var textToScan:String = line
                    var value:NSString?
                    var textScanner:NSScanner = NSScanner(string: textToScan)
                    while textScanner.string != "" {
                        
                        if (textScanner.string as NSString).substringToIndex(1) == "\"" {
                            textScanner.scanLocation += 1
                            textScanner.scanUpToString("\"", intoString: &value)
                            textScanner.scanLocation += 1
                        } else {
                            textScanner.scanUpToString(delimiter, intoString: &value)
                        }
                        
                        // Store the value into the values array
                        values.append(value as! String)
                        
                        // Retrieve the unscanned remainder of the string
                        if textScanner.scanLocation < textScanner.string.characters.count {
                            textToScan = (textScanner.string as NSString).substringFromIndex(textScanner.scanLocation + 1)
                        } else {
                            textToScan = ""
                        }
                        textScanner = NSScanner(string: textToScan)
                    }
                    
                    // For a line without double quotes, we can simply separate the string
                    // by using the delimiter (e.g. comma)
                } else  {
                    values = line.componentsSeparatedByString(delimiter)
                }
                
                // Put the values into the tuple and add it to the items array
                let item = (name: values[0], detail: values[1])
                items?.append(item)
            }
        }
        
        if let managedObjectContext = context {
            for item in items! {
                let catItem = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! MNCCategory
                catItem.name = item.name
                catItem.searchString = item.detail
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print("Shit went wrong")
                }
            }
        }
        
    }

    
    
}