public class classexport 
{
    public List<Account> acct{get;set;}
    public string renderAsdoc{get;set;}
    public boolean pb1{get;set;}
    public string renderAsExcel{get;set;}
 
    public classexport()
    {
        acct=[Select Name,BillingCountry,BillingState,BillingCity from Account];
        pb1=true;
    }
    
    

    //Save as Excel
    public PageReference SaveAsExcel() {
        pb1=false;
        renderAsExcel='application/vnd.ms-excel#Account Report.xls';
        return null;
    }
    
    // Save as word 
    public PageReference SaveAsWord() {
         pb1=false;
        renderAsExcel='application/vnd.ms-word#Account Report.doc';
        return null;
    }

}