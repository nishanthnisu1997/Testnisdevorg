public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        List<Contact> con = new List<Contact>();
            con= [SELECT FirstName, LastName, Email FROM Contact WITH SECURITY_ENFORCED ORDER BY FirstName LIMIT 10];
            system.debug(con);
       return con;
    }

    
}