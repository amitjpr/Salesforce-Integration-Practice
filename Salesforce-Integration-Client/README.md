#SALESFORCE INTEGRATION

##SOAP Integration

###Consume SOAP Based integration from console

Step1 : genrate class from WSDL
Step2 : add endpoint into the remotesite settings
Step3 : get the session id from server
Step 4 : pass the session id 

Sample Code

```Apex 

SoapLeadManager.LeadManager leadserveice = new SoapLeadManager.LeadManager();

string response = leadserveice.createNewLead('Amit ','Kumar',' AmitKumar','amitkumar@gmail.com','+919999999999');

system.debug('response'+response);
