
import Alamofire
import SWXMLHash

internal class NextBusService {
    // singleton
    internal static let sharedInstance = NextBusService()
    
    private let BaseUrl="http://webservices.nextbus.com/service/publicXMLFeed";
    
    internal func getRoutes(completion:(routeList:[[String:String]])->Void) {
        
        Alamofire.request(.GET, BaseUrl, parameters: ["command": "routeList", "a": "ttc"])
            .response(completionHandler: {
                (request, response, data, error) in
                if error != nil {
                    print(error)
                } else {
                    print(data!);
                    let xml = SWXMLHash.parse(data!);
                    var routeInfo = Dictionary<String, String>()
                    
                    // this is supposed to be an array
                    var routeList = [[String:String]]()
                    //print(xml["body"]);
                    for elem in xml["body"]["route"] {
                        routeInfo["title"] = elem.element!.attributes["title"]
                        routeInfo["tag"] = elem.element!.attributes["tag"]
                        routeList.append(routeInfo)
                    }
                    completion(routeList: routeList)
                }
                
            })
       
    }
    
    internal func getStopsForRoutes() {
        
        
    }
    
    internal func getTimeForStop(stopId:String, completion: ()->Void) {
        
        
    }
}