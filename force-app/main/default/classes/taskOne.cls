@RestResource(urlMapping='/Lead/*')
global with sharing class taskOne {            

    @HttpGet
    global static String doGet() {
        String ret = 'fail';
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String leadId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);              
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(leadId);
        lc.setDoNotCreateOpportunity(True);
                
        Lead leadOwner = [SELECT OwnerId FROM Lead WHERE Id=:(leadId)];
        
        Boolean OwnedByUser = String.valueof(leadOwner.OwnerId).startsWith('005');
        
        IF(!OwnedByUser){
            //Generic Adminitrador Id
            lc.setOwnerId('00541000000FmWr');             
        }

        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);           
        Database.LeadConvertResult lcr ;
        try{
            lcr = Database.convertLead(lc);
            system.debug('*****lcr.isSuccess()'+lcr.isSuccess());            
            ret = 'ok';
        } catch(exception ex){
            ret = ex.getMessage();
            system.debug('***NOT CONVERTED**');           
        }
        return ret;
    }   
}