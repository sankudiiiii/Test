@isTest
global class GoogleAPIFailedResultGeneratorMock implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('http://maps.googleapis.com/maps/api/distancematrix/json?origins=411007&destinations=411030&language=en-EN&sensor=false', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"destination_addresses" : [ "Pune, Maharashtra 411009, India" ],"origin_addresses" : [ "Pune, Maharashtra 411030, India" ],"rows" : [{         "elements" : [{"distance" : {"text" : "3.0 km","value" : 3001},               "duration" : {                  "text" : "11 mins",                  "value" : 665               },               "status" : "NOT_FOUND"            }         ]      }   ],  "status" : "OK"}');
        res.setStatusCode(200);
        return res;
    }
}