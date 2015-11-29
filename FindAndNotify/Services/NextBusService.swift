
import Alamofire
import SWXMLHash

internal class NextBusService {
    // singleton
    internal static let sharedInstance = NextBusService()
    
    private let BaseUrl="http://webservices.nextbus.com/service/publicXMLFeed";
    
    internal func getRoutes(completion:(routeList:[Route])->Void) {
        
        Alamofire.request(.GET, BaseUrl, parameters: ["command": "routeList", "a": "ttc"])
            .response(completionHandler: {
                (request, response, data, error) in
                if error != nil {
                    print(error)
                } else {
                    print(data!);
                    let xml = SWXMLHash.parse(data!);
                    
                    // this is supposed to be an array
                    var routeList = [Route]()
                    
                    for elem in xml["body"]["route"] {
                        let route = Route(
                            title:elem.element!.attributes["title"]!,
                            tag:elem.element!.attributes["tag"]!
                        )
                        
                        routeList.append(route)
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