@RestResource(urlMapping='/LeadServiceDelete/*')
global with sharing class LeadServiceDelete {
    
    @HttpDelete
    global static String deleteMatchingLeadInfo(){
        Integer leadCount = 0;
        try{
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            
            System.debug('req.requestURI'+ req.requestURI);
            String requestURI = req.requestURI;

            String leadName = '%'+requestURI.substringAfterLast('/')+'%';
            system.debug('>>>>>>'+leadName);

            List<Lead> leads = [SELECT Id, Name, Company, Email, Phone, MobilePhone FROM Lead WHERE Name like :leadName limit 10];
            leadCount = leads.size();
            if(!leads.isEmpty()){
                delete leads;
            }
        }
        catch(Exception e){
            return 'Exception occured'+e.getMessage();
        }
        return 'lead count'+leadCount;
        
    }
}
