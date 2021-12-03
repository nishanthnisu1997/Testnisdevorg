public class classrequirement {
            public Id accId{get;set;}
            public Account acnts {get;set;}
            public Boolean detailPopUp { get; set; }
            public Boolean x { get; set; }
            List<string> conditions = new List<string>();
            public Boolean editPopUp { get; set; }
            public Boolean newPopUp { get; set; }
            public Boolean csvpopup { get; set; }
            public List<id> tobedel{get; set;}
            public List<Account> massdel{get; set;}
            public Account cnts { get; set; }
            public String searchkey{get;set;} 
            public List<Account> resacnts{get; set;}
            public Blob csvFileBody{get;set;}
            public string csvAsString{get;set;}
            public String[] csvFileLines{get;set;}
            public List<account> acclist{get;set;}
            public List<Account> del{get;set;}
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
    //autocom
            public List<String> listOfStrings {get; set;}
    //export
            public string renderAsExcel{get;set;}
            public boolean pb1{get;set;}
            public boolean pb2{get;set;}
            public string doctypevar{get;set;}
    //wrapper
            public List<DeleteExample> accWrap {get;set;}
            public boolean checkbox{get;set;}
    
    public classrequirement(ApexPages.StandardSetController controller){
            csvFileLines = new String[]{};
            totalRecs=[SELECT Count() from Account];
            blockSize=10;
            x=false;
            doctypevar='html-5.0';
            pb1=false;
            pb2=True;
            pagenumber = 1;
            listOfStrings = new List<String>();
      for(Account a: [SELECT id, Name From Account]){
            listOfStrings.add(a.name);
      }
            allacnts(); 
      }
    
    public List<DeleteExample> allacnts(){
            accWrap = new List<DeleteExample>();
            System.debug('accWrap' +accWrap);
            system.debug('blocksize' + blocksize);
    for(Account a :[SELECT Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site FROM Account Order by Name LIMIT :blockSize OFFSET :index]){
            System.debug('accWrap'+a);
            DeleteExample d = new DeleteExample(false,a);
            accWrap.add(d);
            System.debug('accWrap'+d);
    }
            System.debug('accWrap'+accWrap);
            return accWrap;
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
       public void del(){
           try{
           Account aptid = new Account();
          aptid=[SELECT Name,id FROM Account Where id= :accId];
          delete aptid;
          allacnts();
          x=True;
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,' Account is deleted' )); 
           }catch(Exception e){
          x=True;
          }
    }

      public void clearpopup(){
        x= false;
    }

    //Save as Excel
    public void SaveAsExcel() 
    {                 pb2=false;
             pb1=True;
      doctypevar=' ';
         for(Account a :[SELECT Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site FROM Account Order by Name]){
        System.debug('accWrap'+a);
            DeleteExample d = new DeleteExample(false,a);
             accWrap.add(d);}
        renderAsExcel='application/vnd.ms-excel#Account Report.xls';
                        csvpopup=false;
    }
    
    //mass del functions
       public void deletecheckedRecs (){
          List<Account> selectedacnts = new List<Account>();
         for(deleteExample d :accWrap){
//Fetching data of the selected records
            if(d.checkbox == true){
//deleting student records based on lists index
                selectedacnts.add(d.accObj);
            }}
         system.debug('List del'+selectedacnts);
                         delete selectedacnts;
         allacnts();
            x=True;
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'A selected Account is deleted' ));      
    }
    
    //show poopup function
    public pagereference showpopupcsv(){
        csvpopup=True;
        return null;
    }
       public Void showPopupdetail() {
        acnts =[select Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue from Account  where id=:accId];
       detailpopup=true;
       }
    
      public void showPopupedit() {
      acnts =[select  Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue from Account where id=:accId];
          editPopUp=true;
      }
    
    public void showPopupnew() {
        acnts = new Account();
       newPopUp=true;
    }
    //clear function
       public void clear(){
                  searchkey = null;
           beginning();
                  searchbox();
           getnxt();
           getprev();
             system.debug('totalRecsclear'+ totalRecs);                 
       }
    
    public void save(){
        
        upsert acnts;
       x=True;
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'A New Account is inserted' ));  
        
        
        detailPopUp=false;
                       newPopUp=false;
          editPopUp=false;
          allacnts();
       }
    public void saveandnew(){
        insert acnts;
                         x=True;
        showPopupnew();
            }
    
    //seach function
         public void searchhlp(){
        index=0;
        totalRecs=0;
             pagenumber=1;
       system.debug('seaerchkey' +searchkey);
       
            searchbox();
               }
     
          Public PageReference searchbox(){ 
              totalRecs=0;
         system.debug('seaerchkey' +searchkey);
            if(accWrap!= null){
                    accWrap.clear();
                }   
            if(searchkey == null){
                                 totalRecs=[SELECT Count() FROM Account]; 
                allacnts();
                system.debug('seaerchkey'+ searchkey);
            }else{
                String searchval='%'+searchkey+'%';
                       totalRecs=[SELECT Count() FROM Account  WHERE Name Like :searchval]; 
                                system.debug('totalRecs'+ totalRecs);
                        accWrap = new List<DeleteExample>();

                    for(Account a :[SELECT Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site FROM Account  WHERE Name Like :'%'+searchkey+'%' OR Phone Like :'%'+searchkey+'%' OR Phone Like :'%'+searchkey+'%' Order by Name LIMIT :blockSize OFFSET :index]){
            accWrap.add(new DeleteExample(checkbox,a));
    }
                system.debug('seaerchkey'+searchkey);
                system.debug('size' + accWrap.size());
                system.debug('index'+ index);}
      
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
 
  public void sortvalue() {
         if(accWrap!= null){
                    accWrap.clear();
                }   
       //build the full sort expression
       string sortFullExp = sortExpression  + ' ' + sortDirection;
      
         if(searchkey == ' '){
       //query the database based on the sort expression
           accWrap = new List<DeleteExample>();
           for(Account a : Database.query('Select Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site from Account order by ' + sortFullExp + ' limit '+ blocksize +' OFFSET '+ index)){
            accWrap.add(new DeleteExample(checkbox,a));
    }
      }else{
                          String searchval='%'+searchkey+'%';
          for(Account a :Database.query('Select Name,Type,AccountNumber,Phone,Website,Industry,AccountSource,Rating,AnnualRevenue,Site from Account where Name Like  \'%'  + searchkey + '%\'  order by ' + sortFullExp + ' limit '+ blocksize +' OFFSET '+ index )){
            accWrap.add(new DeleteExample(checkbox,a));
    }

      }
          
   }


    //import functions
  public void importCSVFile(){
      Try{
                   acclist = New List<Account>(); 
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
            
           for(Integer i=1;i<csvFileLines.size();i++){
               Account accObj = new Account();
               string[] csvRecordData = csvFileLines[i].split(',');
               accObj.Name = csvRecordData[0] ;             
               accObj.Site = csvRecordData[1];                                                                        
               acclist.add(accObj);   
           }
        insert acclist;
         allacnts(); 
        csvpopup=false;

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
        system.debug('blocksize' + blocksize);
        index = index - blockSize;  
           searchbox();
       sortvalue();
     pagenumber=Pagenumber-1;

    }  
      
    public void next() { 
                system.debug('blocksize' + blocksize);
        index = index + blockSize; 
       searchbox();    
        sortvalue();
        pagenumber=Pagenumber+1;
    }  
  
   
    public void end() {  
                                              if(math.mod(totalRecs,blockSize)==0){
        index = (totalrecs-blockSize)- math.mod(totalRecs,blockSize);  
       searchbox();
       sortvalue();
         pagenumber=(totalRecs/blockSize);

        } else{
            index = totalrecs - (math.mod(totalRecs,blockSize));  
       searchbox();
        sortvalue();
         pagenumber=(totalRecs/blockSize)+1;

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
      
  
    public class DeleteExample{
     public boolean checkbox{get;set;}
        public account accObj{get;set;}
        public DeleteExample(boolean checkboxselect, Account a)
        {
                    System.debug('a'+a+checkboxselect);

            checkbox = checkboxselect;
            accObj   = a;
                                System.debug('a'+accObj+checkbox);

        }
} 
}