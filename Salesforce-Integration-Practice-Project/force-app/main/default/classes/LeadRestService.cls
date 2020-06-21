@RestResource(urlMapping='/LeadService/*')
global with sharing class LeadRestService {
    
    @HttpGet
    global static List<Lead> getLeadInfo(){
        List<Lead> leads = [SELECT Id, Name, Company, Email, Phone, MobilePhone FROM Lead limit 10];
        return leads;
    }
}
