public class testrequire {
              public Id accId{get;set;}
              public Account acnts {get;set;}
              public Boolean detailPopUp { get; set; }
              public Boolean isselesctcheckbox { get; set; }
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
              Public integer totalRecs{get; set;}
              Public integer index = 0;
              Public integer blockSize{get; set;}
              public integer pagenumber{get; set;}
              public integer totalpages{get; set;}
      //sorting
              public String sortDirection = 'ASC';
              public String sortExp = 'name';
        public string renderAsExcel{get;set;}


    public testrequire(ApexPages.StandardSetController controller){
            csvFileLines = new String[]{};
                totalRecs=0;
                blockSize=10;
            allacnts();  
            totalRecs=[SELECT Count() FROM Account];     
            List<Account> massdel = new list<Account>();
             pagenumber = 1;
    }
    
    public List<Account> allacnts(){
        allacnts=[SELECT Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site FROM Account Order by Name LIMIT :blockSize OFFSET :index];
        return allacnts;
    }
    
   //closepoopup function 
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
       
    //delte function
       public PageReference del(){
                  Account aptid = new Account();
        aptid=[SELECT Name,id FROM Account Where id= :accId];
               delete aptid;
               pagereference ref=new pagereference('/apex/requirement');
        ref.setredirect(true);
        return ref;
    }
    
    //Save as Excel
    public PageReference SaveAsExcel() 
    {        csvpopup=false;
        renderAsExcel='application/vnd.ms-excel#Account Report.xls';
        return null;
    }
    
    //mass del functions
     public PageReference massdel(){
        massdel=[SELECT Name,id FROM Account Where id= :tobedel];
               delete massdel;
               pagereference ref=new pagereference('/apex/requirement');
        ref.setredirect(true);
        return ref;
    }
    
    //show poopup function
    public pagereference showpopupcsv(){
        csvpopup=True;
        return null;
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
    //clear function
       public pagereference clear(){
                  searchkey = ' ';
                  searchhlp();
             system.debug('totalRecsclear'+ totalRecs);
                system.debug('seaerchkeyclear'+ searchkey);
           pagereference ref=new pagereference('/apex/requirement');
        ref.setredirect(true);
        return ref;
                                         
       }
    
    public pagereference save(){
        upsert acnts;
           pagereference ref=new pagereference('/apex/requirement');
        ref.setredirect(true);
        return ref;
                
       }
    
    //seach function
    public void searchhlp(){
        index=0;
        totalRecs=0;
        if(allacnts != null){
            allacnts=null;
        } system.debug('seaerchkey' +searchkey);
       
            searchbox();
               }
    
          Public PageReference searchbox(){ 
        Try{  system.debug('seaerchkey' +searchkey);
            if(allacnts!= null){
                    allacnts.clear();
                }   
            if(searchkey == ' '){
                allacnts();
                system.debug('seaerchkey'+ searchkey);
                 totalRecs=[SELECT Count() FROM Account]; 
            }else{
                String searchval='%'+searchkey+'%';
                       totalRecs=[SELECT Count() FROM Account  WHERE Name Like :searchval]; 
                                system.debug('totalRecs'+ totalRecs);

             allacnts =[SELECT Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site FROM Account  WHERE Name Like :'%'+searchkey+'%' OR Phone Like :'%'+searchkey+'%' OR Phone Like :'%'+searchkey+'%' Order by Name LIMIT :blockSize OFFSET :index];
                system.debug('seaerchkey'+searchkey);
                system.debug('size' + allacnts.size());
                system.debug('index'+ index);}
        }
        catch(Exception ex1)
         {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Search box should not be empty'));
         }
                return null;

    }
    
    //sorting fuctions
     public String sortExpression
   {
     get
     {
        return sortExp;
     }
     set
     {
       //if the column is clicked on then switch between Ascending and Descending modes
       if (value == sortExp)
         sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
       else
         sortDirection = 'ASC';
       sortExp = value;
     }
   }
public String getSortDirection()
 {
    //if not column is selected
    if (sortExpression == null || sortExpression == '')
      return 'ASC';
    else
     return sortDirection;
 }

 public void setSortDirection(String value)
 {  
   sortDirection = value;
 }
 
  public PageReference sortvalue() {
       //build the full sort expression
       string sortFullExp = sortExpression  + ' ' + sortDirection;
      
         if(searchkey == ' '){
       //query the database based on the sort expression
        allacnts = Database.query('Select Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site from Account order by ' + sortFullExp + ' limit '+ blocksize +' OFFSET '+ index);
      }else{
                          String searchval='%'+searchkey+'%';

         allacnts = Database.query('Select Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site from Account where Name Like  \'%'  + searchkey + '%\'  order by ' + sortFullExp + ' limit '+ blocksize +' OFFSET '+ index );
      }
          return null;
   }


    //import functions
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
    
 //pagination functions
   public void beginning() { 
       Pagenumber=1;
        index = 0; 
       searchbox();
       sortvalue();
    }  
      
    public void previous() {   
        index = index - blockSize;  
        pagenumber=Pagenumber-1;
           searchbox();
        sortvalue();
    }  
      
    public void next() {  
   
        index = index + blockSize; 
                pagenumber=Pagenumber+1;
       searchbox();    
        sortvalue();
    }  
  
    public void end() {  
        if(math.mod(totalRecs,blockSize)==0){
        index = (totalrecs-blockSize)- math.mod(totalRecs,blockSize);  
            pagenumber=(totalRecs/blockSize);
       searchbox();
        sortvalue();
        } else{
            index = totalrecs - (math.mod(totalRecs,blockSize));  
            pagenumber=(totalRecs/blockSize)+1;
       searchbox();
        sortvalue();
        }}         
      
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