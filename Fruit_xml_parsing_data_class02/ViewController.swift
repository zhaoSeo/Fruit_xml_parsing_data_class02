//
//  ViewController.swift
//  Fruit_xml_parsing_data_class02
//
//  Created by Sang won Seo on 01/10/2018.
//  Copyright © 2018 Sang won Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var myFruitData = [FruitData]()
    var fName = ""
    var fColor = ""
    var fCost = ""
    
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
            if let myParser = XMLParser(contentsOf: path) {
                myParser.delegate = self
                //parsing start
                if myParser.parse() {
                    print("Parsing succeed")
                    for i in 0 ..< myFruitData.count {
                        print(myFruitData[i].name)
                        print(myFruitData[i].color)
                        print(myFruitData[i].cost)
                    }
                } else {
                    print("Parsing failed")
                }
            } else {
                print("path failed")
            }
        } else {
            print("file error")
        }
    }
    // XMLParserDelegate method call
    // tag code 만났을 때
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        print(currentElement)
    }
    // tag 다음의 문자열을 만났을 때
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //공백 제거
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        //빈칸이 아닐시 출력
        if !data.isEmpty {
            switch currentElement {
            case "name" : fName = data
            case "color" : fColor = data
            case "cost" : fCost = data
            default : break
            }
        }
    }
    // </tag>를 만났을 때
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let myItem = FruitData()
            myItem.name = fName
            myItem.color = fColor
            myItem.cost = fCost
            myFruitData.append(myItem)
        }
    }


}

