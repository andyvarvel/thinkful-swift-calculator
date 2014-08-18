// Playground - noun: a place where people can play

import Foundation

struct DataProvider {
    var baseURL:String = "this needs to be changd"
    
    static var dataProtocol:String = "http://"
    
    func printme() {
        println("baseURL: \(fullURL())")
    }
    
    func fullURL() -> String {
        return "\(DataProvider.dataProtocol)\(baseURL)"
    }
}

class DataProvider2 {
    var baseURL:String = "foo"
    
    class func dataProtocol() -> String {
        return "https://"
    }
    
    func printme() {
        println("baseURL: \(fullURL())")
    }
    
    func fullURL() -> String {
        return "\(DataProvider2.dataProtocol())\(baseURL)"
    }
}


var myDataProvider = DataProvider()
myDataProvider.baseURL = "localhost:3000/best"
myDataProvider.printme()

var secondDP = myDataProvider
DataProvider.dataProtocol = "https://"
secondDP.baseURL = "seanzehnder.com/foo"
secondDP.printme()
myDataProvider.printme()

println("----- now, if it were a CLASS ----")

var myDP2 = DataProvider2()
myDP2.printme()
DataProvider2.dataProtocol()

var myDP3 = myDP2
myDP3.baseURL = "google.com/somethingcool"
myDP3.printme()
myDP2.printme()





