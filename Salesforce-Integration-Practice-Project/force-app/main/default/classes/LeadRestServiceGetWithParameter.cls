@RestResource(urlMapping='/LeadServiceGet/*')
global with sharing class LeadRestServiceGetWithParameter {
    
    @HttpGet
    global static List<Lead> getLeadInfo(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        System.debug('req.requestURI'+ req.requestURI);
        String requestURI = req.requestURI;

        String leadName = '%'+requestURI.substringAfterLast('/')+'%';
        system.debug('>>>>>>'+leadName);

        List<Lead> leads = [SELECT Id, Name, Company, Email, Phone, MobilePhone FROM Lead WHERE Name like :leadName limit 10];
        return leads;
    }
}
