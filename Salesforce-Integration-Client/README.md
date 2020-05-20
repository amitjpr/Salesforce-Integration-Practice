# SALESFORCE INTEGRATION

## SOAP Integration

### Consume SOAP Based integration from console

Step1 : genrate class from WSDL
Step2 : add endpoint into the remotesite settings
Step3 : get the session id from server
              a) get the partner / enterprise wsdl from server
              b) genrate the apex class at client side using WSDL  
Step 4 : pass the session id 


### NOTE : 
      1) The WSDL document can be at most 1MB.
      2) When the document is parsed, each namespace becomes an Apex class.
      3) A single Apex class can be at most 100,000 characters

### Sample Code

```Java 

SoapLeadManager.LeadManager leadserveice = new SoapLeadManager.LeadManager();

string response = leadserveice.createNewLead('Amit ','Kumar',' AmitKumar','amitkumar@gmail.com','+919999999999');

system.debug('response'+response);
