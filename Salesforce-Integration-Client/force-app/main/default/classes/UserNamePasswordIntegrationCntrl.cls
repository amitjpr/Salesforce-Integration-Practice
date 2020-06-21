public with sharing class UserNamePasswordIntegrationCntrl {
   

    public string leadSearchName{get;set;}
    public list<LeadResponse> leadResponseList{get;set;}
    public LeadResponse leadData {get;set;}
    public TokenResponse tokenRes {get;set;}
    
    public string leadCreateMessage{get;set;}

    public UserNamePasswordIntegrationCntrl(){

      leadResponseList = new list<LeadResponse>();
      leadData = new LeadResponse();

    }

    public void requestAccessToken(){

    string accesstokenEndpoint = IntegrationConstants.ENDPOINT;
    accesstokenEndpoint = accesstokenEndpoint+'?grant_type=password'; 
    accesstokenEndpoint = accesstokenEndpoint+'&client_id='+IntegrationConstants.CLIENT_ID;
    accesstokenEndpoint = accesstokenEndpoint+'&client_secret='+IntegrationConstants.CLIENT_SECRET;
    accesstokenEndpoint = accesstokenEndpoint+ '&username='+IntegrationConstants.USERNAME;
    accesstokenEndpoint = accesstokenEndpoint+ '&password='+IntegrationConstants.PASSWORD;

    Http h = new Http();

    HttpRequest req = new HttpRequest();
    req.setEndpoint(accesstokenEndpoint);
    req.setMethod('POST');
    HttpResponse hresp = h.send(req);
    system.debug('***hres.getBody()'+hresp.getBody());
    tokenRes = (TokenResponse) JSON.deserialize(hresp.getBody(), TokenResponse.class)    ;
    //System.debug('----->>>>'+tokenRes);
    }

    public void requestLeadDetails(){
        system.debug('---->>>>>leadSearchName::::'+leadSearchName);
        //get access token
        requestAccessToken();
        //accesstoken pass to acces sother rest resource
        string leadGetEndpoint =  tokenRes.instance_url+'/services/apexrest/LeadServiceGet/'+leadSearchName;
        system.debug('get lead details endpoint'+leadGetEndpoint);

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(leadGetEndpoint);
        req.setMethod('GET');
        req.setHeader('Authorization','Bearer '+tokenRes.access_token);
        req.setHeader('Content-Type', 'application/json');
        HttpResponse res = h.send(req);
        system.debug('res body'+res.getBody());
        if(res.getStatusCode()==200){
            leadResponseList = (list<leadResponse>) JSON.deserialize(res.getBody(), list<leadResponse>.class);    
        }
        system.debug('***leadResponseList'+leadResponseList);
    }

    public void createLead(){
        System.debug('---->>>>leadData'+leadData);
        
        string requestJson = JSON.serialize(leadData, true);
        System.debug('------>>>>>json::'+requestJson);
        
        requestAccessToken();
        string leadcreateEndpoint = tokenRes.instance_url+'/services/apexrest/LeadServicePost/';

        http h = new http();
        httpRequest req = new HttpRequest();
        req.setEndpoint(leadcreateEndpoint);
        req.setMethod('POST');
        req.setBody(requestJson);
        req.setHeader('Authorization','Bearer '+tokenRes.access_token);
        req.setHeader('Content-Type', 'application/json');
        Httpresponse res = h.send(req);
        system.debug('res==>'+res.getBody());
        leadCreateMessage = res.getBody();
    }
   
}
