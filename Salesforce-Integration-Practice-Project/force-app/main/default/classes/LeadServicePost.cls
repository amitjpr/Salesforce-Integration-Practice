@RestResource(urlMapping='/LeadServicePost/*')
global with sharing class LeadServicePost {
    
    @HttpPost
    global static string createNewLead(string FirstName,string LastName,string Company,string Email,string Phone){
        string respMessage;
        try{
            lead l = new lead();
            l.FirstName = FirstName;
            l.LastName = LastName;
            l.Company = Company;
            l.Email = Email;
            l.Phone = Phone;
            insert l;
            respMessage = 'Lead created succesfully with id as: '+l.id;
        }
        catch(Exception ex){
            respMessage = 'Error occured during new lead creation=>'+ex.getMessage();     
        }
        return respMessage;
    }
}