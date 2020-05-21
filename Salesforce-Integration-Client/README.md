# SALESFORCE INTEGRATION

## SOAP Integration

### Consume SOAP Based integration from console using basic authentication:
		Step 1 : genrate class from WSDL.
		Step 2 : add endpoint into the remotesite settings.
		Step 3 : get the session id from server.
              		a) get the partner / enterprise wsdl from server.
              		b) genrate the apex class at client side using WSDL
                  c) add remote site setting - `https://login.salesforce.com`
                  d) invoke `partnerSoapSforceCom` class `login` method 
                  e) Save the result in 'LoginResult' instance
                  f) `sessionId` is a instance member of `LoginResult` class use like  `instance.sessionId`
		Step 4 : pass the session id .
                  a) create instance of `SessionHeader_element` and set the session id
                  b) set the leadservice sessionheader with instance of `SessionHeader_element`

### Sample Code

```Apex 

//step 1 - invoke my partner WSDL class login
string username = '<username>';
string password = '<password> + <security token>';
partnerSoapSforceCom.soap soapObj = new partnerSoapSforceCom.soap();
partnerSoapSforceCom.LoginResult logRes =soapObj.login(username,password);

system.debug('logRes'+logRes);
system.debug('logRes.sessionId:' + logRes.sessionId);
//step 2 - sessionHeader objec to pass session id

SoapLeadManager.SessionHeader_element sessionObj = new SoapLeadManager.SessionHeader_element();
sessionObj.sessionId = logRes.sessionId;

//step 3- session obj with soap call

SoapLeadManager.LeadManager leadserveice = new SoapLeadManager.LeadManager();
leadserveice.SessionHeader = sessionObj;
string response = leadserveice.createNewLead('Amit ','Kumar',' AmitKumar','amitkumar@gmail.com','+919999999999');

system.debug('response'+response);

```

#### NOTE : 
      1) The WSDL document can be at most 1MB.
      2) When the document is parsed, each namespace becomes an Apex class.
      3) A single Apex class can be at most 100,000 characters

### Consume SOAP Based integration from console using OAuth

get token from any OAuth flow and use it as session id

```Apex

  String consumerKey = '3MVG95jctIhbyCpqKBhfhUgQITLOUF_gUjKgwoNaaVY0VMiyiW6dznmPci7ADZKiH5VSXG79Xowl.XS9zXlfC';
  String consumersecret = '1D65EC27D47699AA7F5A36A707EA988D2298202D0B6DB72965BA721312FF433D';

  Http h = new Http();
  HttpRequest hreq = new HttpRequest();
  hreq.setEndpoint('https://login.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG95jctIhbyCpqKBhfhUgQITLOUF_gUjKgwoNaaVY0VMiyiW6dznmPci7ADZKiH5VSXG79Xowl.XS9zXlfC&client_secret=1D65EC27D47699AA7F5A36A707EA988D2298202D0B6DB72965BA721312FF433D&username=debasis@server.com&password=Bunu@1234ddvDVSKSBgF2fzQHNYz1CL5J');
  
  hreq.setMethod('POST');
  string username = '<user_name>';
  string password = '<password + Security token>';
  blob headervalue = Blob.valueOf(username+':'+password);
  string authorizationValue = 'BASIC'+EncodingUtil.base64Encode(headervalue);
  hreq.setHeader('Authorization',authorizationValue);
  HttpResponse hresp =  h.send(hreq);
  system.debug('hresp'+hresp.getBody());
  string atoken;
  string instanceURL;
  JSONParser parser = JSON.createParser(hresp.getBody());
  
  while(parser.nextToken() !=NULL){
    if((parser.getCurrentToken() == JSONTOKEN.FIELD_NAME) && parser.getText()=='access_token'){
        parser.nextToken();
        atoken = parser.getText();
    }

    if((parser.getCurrentToken() == JSONTOKEN.FIELD_NAME) && parser.getText()=='instance_url'){
        parser.nextToken();
        instanceURL = parser.getText();
    }
  }

  SoapLeadManager.SessionHeader_element sessionObj = new SoapLeadManager.SessionHeader_element();
  sessionObj.sessionId = atoken;
  SoapLeadManager.LeadManager LM = new SoapLeadManager.LeadManager();
  LM.SessionHeader = sessionObj;
  lm.endpoint_x = instanceURL+'/services/Soap/class/LeadManager';
  string res = LM.createNewLead('KUMAR','Rathore','AK ENterprises','ak123@test.com','+9199999999');
  system.debug('response is'+res);
```


