public class edit{
              public Id accId{get;set;}
              public Account acnts {get;set;}
              public Boolean detailPopUp { get; set; }
              public Boolean isselesctcheckbox { get; set; }
              List<string> conditions = new List<string>();
              public Boolean editPopUp { get; set; }
              public Boolean newPopUp { get; set; }
              public Boolean csvpopup { get; set; }
              public List<id> tobedel{get; set;}
              public List<Account> massdel{get; set;}
              public Account cnts { get; set; }
              public String searchkey{get;set;} 
              public List<Account> resacnts{get; set;}
              public List<Account> allacnts{get; set;}
              public Blob csvFileBody{get;set;}
              public string csvAsString{get;set;}
              public String[] csvFileLines{get;set;}
              public List<account> acclist{get;set;}
              Public List<Account> sortList{get; set;}
    //pagination
    
              Public integer totalRecs = 0; 
              Public integer index = 0;
              Public integer blockSize =10; 
      
    public edit(ApexPages.StandardSetController controller){
            csvFileLines = new String[]{};
            allacnts();  
            totalRecs=[SELECT Count() FROM Account];     
            List<Account> massdel = new list<Account>();
      }
    
    public List<Account> allacnts(){
        allacnts=[SELECT Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site FROM Account Order by Name LIMIT :blockSize OFFSET :index];
        return allacnts;
    }
    
    public void closePopupdetail() {
        detailpopup=false;
      }
    
    public void closePopupcsv() {
        csvpopup=false;
      }
  
    public void closePopupedit() {
        editPopUp=false;
      }
    
    public void closePopupnew() {
        newPopUp=false;
              }
    
    public pagereference showpopupcsv(){
        csvpopup=True;
        return null;
    }
    
       Account aptid = new Account();
       public PageReference del(){
        aptid=[SELECT Name,id FROM Account Where id= :accId];
               delete aptid;
               pagereference ref=new pagereference('/apex/requirement');
        ref.setredirect(true);
        return ref;
    }
    
     public PageReference massdel(){
        massdel=[SELECT Name,id FROM Account Where id= :tobedel];
               delete massdel;
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
          return null;
      }
    
    public PageReference showPopupnew() {
        acnts = new Account();
       newPopUp=true;
          return null;
    }
    
       public void clear(){
                  searchkey = ' ';
              searchhlp();
       }
    
    public pagereference save(){
        upsert acnts;
        pagereference ref=new pagereference('/apex/requirement');
        ref.setredirect(true);
        return ref;
       }
    
    public void searchhlp(){
        index=0;
        totalRecs=0;
        if(allacnts != null){
            allacnts=null;
        }
                        system.debug('searchkey' +searchkey);

            searchbox();
                         conditions.clear();
               }
    
          Public PageReference searchbox(){ 
        Try{    
            if(allacnts!= null){
                    allacnts.clear();
                }   
            
            if(searchkey == ' '){
                allacnts();
                                system.debug('ifsearchkey' + searchkey);
                 totalRecs=[SELECT Count() FROM Account]; 
                                system.debug('totalRecs' +totalRecs);

            }else{
                                                              system.debug('searchkey else' + searchkey);
                                                                              system.debug('index' + index);
                                                              system.debug('blocksize' + blocksize);
                       totalRecs=[SELECT Count() FROM Account  WHERE Name Like :searchkey+'%']; 
               allacnts =[SELECT Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site FROM Account  WHERE Name Like :searchkey+'%' Order by Name LIMIT :blockSize OFFSET :index];
                system.debug('size' + allacnts);
                system.debug('index'+ index);}
        }
        catch(Exception ex1)
         {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Search box should not be empty'));
         }
                return null;

    }
    
  public void importCSVFile(){
      Try{
                   acclist = New List<Account>(); 
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
         allacnts(); 
            closePopupcsv();     

        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }  
  }
 
   public void beginning() {  
  
        index = 0; 
       searchbox();
       
  
    }  
      
    public void previous() {  
  
        index = index - blockSize;  
           searchbox();
        
    }  
      
    public void next() {  
   
        index = index + blockSize;  
       searchbox();
         
    }  
  
    public void end() {  

       
        index = totalrecs - math.mod(totalRecs,blockSize);  
       searchbox();
    }          
      
    public boolean getprev() {
        if(index==0){
                   return true;
        }else
        {
            return false;
        }
    }
      
    public boolean getnxt() {  
  
        if((index + blockSize) > totalRecs-1)  
        return true;  
        else  
        return false;  
    }      
      
  
 
}