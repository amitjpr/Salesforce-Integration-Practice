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
                  a) 


#### `NOTE` : 
      1) The WSDL document can be at most 1MB.
      2) When the document is parsed, each namespace becomes an Apex class.
      3) A single Apex class can be at most 100,000 characters

### Sample Code

```Java 

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
