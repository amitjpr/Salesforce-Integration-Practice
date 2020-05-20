global class LeadManager {
    
    /**
     * createNewLead  A webservice method to create a lead record with the lease information. 
     *  
     * @param  lastName    lastName of lead
     * @param  firstName   firstName lead
     * @param  companyName companyName lead
     * @param  email       email lead
     * @param  phone       phone lead
     * @return             return description
     */ 
    webservice static String createNewLead(String lastName, 
                                            String firstName, 
                                            String companyName, 
                                            String email, 
                                            String phone){

        try{
            Lead lead       = new Lead();
            lead.FirstName  = firstName;
            lead.LastName   = lastName;
            lead.Company    = companyName;
            lead.Email      = email;
            lead.Phone      = phone;
            
            insert lead;

            return lead.Id;
        }
        catch(Exception e){
            return 'Error during prossicing your request';
        }
        
    }
}
