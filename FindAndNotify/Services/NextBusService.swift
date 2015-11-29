
import Alamofire
import SWXMLHash

internal class NextBusService {
    // singleton
    internal static let sharedInstance = NextBusService()
    
    private let BaseUrl="http://webservices.nextbus.com/service/publicXMLFeed";
    
    internal func getRoutes() {
        
        Alamofire.request(.GET, BaseUrl, parameters: ["command": "routeList", "a": "ttc"])
            .response(completionHandler: {
                (request, response, data, error) in
                if error != nil {
                    print(error)
                } else {
                    print(data!);
                    let xml = SWXMLHash.parse(data!);
                    print(xml["body"]);
                }
                
            })
       
    }
    
    internal func getStopsForRoutes() {
        
        
    }
    
    internal func getTimeForStop(stopId:String, completion: ()->Void) {
        
        
    }
}