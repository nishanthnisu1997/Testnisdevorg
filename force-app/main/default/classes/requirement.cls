public class requirement {
          public Id accId{get;set;}
              public Account acnts {get;set;}
         public Boolean detailPopUp { get; set; }
       public Boolean editPopUp { get; set; }
             public Boolean newPopUp { get; set; }
    public Account cnts { get; set; }
      public String searchkey{get;set;} 
   public List<Account> resacnts{get; set;}
       public List<Account> allacnts{get; set;}
    public Blob csvFileBody{get;set;}
public string csvAsString{get;set;}
public String[] csvFileLines{get;set;}
    public List<account> acclist{get;set;}
    public requirement(ApexPages.StandardSetController controller){
            csvFileLines = new String[]{};
                    acclist = New List<Account>(); 

                    allacnts();           
        }
    public List<Account> allacnts(){
        allacnts=[SELECT Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site FROM Account];
        return allacnts;
    }
    
       public void closePopupdetail() {
        detailpopup=false;
              }
       public void closePopupedit() {
        editPopUp=false;
                }
       public void closePopupnew() {
        newPopUp=false;
              }
       Account aptid = new Account();
       public PageReference del(){
        aptid=[SELECT Name,id FROM Account Where id= :accId];
               delete aptid;
               pagereference ref=new pagereference('/apex/requirement');
        ref.setredirect(true);
        return ref;
    }
       public PageReference showPopupdetail() {
    acnts =[select Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue from Account  where id=:accId];
       detailpopup=true;
           return null;
       }
    
      public PageReference showPopupedit() {
    acnts =[select  Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue from Account where id=:accId];
       editPopUp=true;
          return null;}
    public PageReference showPopupnew() {
        acnts = new Account();
       newPopUp=true;
          return null;}
       public pagereference clear(){
         allacnts();
           return null;
       }
    public pagereference save(){
        upsert acnts;
        pagereference ref=new pagereference('/apex/requirement');
        ref.setredirect(true);
        return ref;
       }
    Public PageReference searchbox(){
        Try{
            If(searchkey!= ' '){
        allacnts =[FIND :searchkey RETURNING Account(Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site)][0];
         
            }
        }
         catch(Exception ex1)
         {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Search box should not be empty'));
         }
                return null;

    }
  public void importCSVFile(){
      Try{
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
            
           for(Integer i=1;i<csvFileLines.size();i++){
               Account accObj = new Account() ;
               string[] csvRecordData = csvFileLines[i].split(',');
               accObj.Name = csvRecordData[0] ;             
               accObj.Site = csvRecordData[1];                                                                        
               acclist.add(accObj);   
           }
        insert acclist;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }  
  }
}