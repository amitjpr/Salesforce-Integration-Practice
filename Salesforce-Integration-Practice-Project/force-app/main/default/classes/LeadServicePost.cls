@RestResource(urlMapping='/LeadServicePost/*')
global with sharing class LeadServicePost {
    
    @HttpPost
    global static string createNewLead(string fname,string lname,string cname,string leademail,string leadphoneNumber){
        string respMessage;
        try{
            lead l = new lead();
            l.FirstName = fname;
            l.LastName = lname;
            l.Company = cname;
            l.Email = leademail;
            l.Phone = leadphoneNumber;
            insert l;
            respMessage = 'Lead created succesfully with id as: '+l.id;
        }
        catch(Exception ex){
            respMessage = 'Error occured during new lead creation=>'+ex.getMessage();     
        }
        return respMessage;
    }
}