//
//  ViewController.swift
//  Boogie1
//
//  Created by Arvind Subramanian on 6/14/15.
//  Copyright (c) 2015 iOS Boogie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let filePath = NSBundle.mainBundle().pathForResource("small", ofType: "txt"), contents = NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil) {
            findTheDuplicates(contents as String)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    function that counts
    how often each word appears in the text and prints:
    word1 count1
    word2 count2
    ...
    
    Print the above list in order sorted by word (swift will sort punctuation to
    come before letters -- that's fine). Store all the words as lowercase,
    so 'The' and 'the' count as the same word.
    */
    
    func findTheDuplicates(fileContents: String) {

        // There are a bunch of ways to do this, but here's one:
        // let's break down the problem
        
        // 1. take the giant string and turn it into individual words
        var wordList = split(fileContents){$0 == " " || $0 == "\n"}
        
        // 2. make a dictionary of [words : count]
        var wordCount = [String : Int]()
        
        // 3. loop through each word in the giant string
        // 3. make each word lower case
        // 4. remove whitespace surrounding each word
        for i in 0...(wordList.count-1) {
            wordList[i] = wordList[i].lowercaseString
            wordList[i] = wordList[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
        
        // 5. add an entry in the dictionary for each word and increment the 'count' each time you see it again in the dictionary
        for i in 0...(wordList.count-1) {
            // line below: if wordCount already contains the key, increment
            if let curr = wordCount[wordList[i]]{
                wordCount[wordList[i]] = wordCount[wordList[i]]! + 1
            }
            // else, create the key/value pair and initialize the count to 0
            else {
                wordCount[wordList[i]] = 1
            }
        }
        
        // 6. once you're done get an array of all the words in the dictionary (all the keys)
        var wordKeys: [String] = wordCount.keys.array
        
        // 7. sort the words alphabetically
        let sortedKeys = wordKeys.sorted { $0 < $1 }
        
        // 8. loop through the array and print out the count for each word
        for i in 0...(wordCount.count-1) {
            print("Word: \(sortedKeys[i]), count: \(wordCount[sortedKeys[i]]!)\n" )
        }
        
        // Some useful documentation:
        // see a stackoverflow for the split method: http://stackoverflow.com/questions/25678373/swift-split-a-string-into-an-array
        
        // removing whitespace from a string: http://stackoverflow.com/questions/28570973/how-should-i-remove-all-the-spaces-from-a-string-swift
        
        // to sort an array in swift: http://stackoverflow.com/questions/25223058/how-to-sort-an-array-in-swift
        
        
    }
    
}

