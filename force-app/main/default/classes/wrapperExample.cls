public class wrapperExample {
    public List<accountWrapper> wrapAcnts{get;set;}
        public List<accountWrapper> wrapAcntssel{get;set;}
                public Boolean checkbox{get;set;}
            public Account acctst{get;set;}


    public wrapperExample(){
        wrapAcnts=new List<accountWrapper>();
                wrapAcntssel=new List<accountWrapper>();

        accountWrapper objWrap = new accountWrapper(false, acctst);
        objWrap.accName='Nis1';
                objWrap.accPhone='9600';
                objWrap.accRating='Hot';
        wrapAcnts.add(objWrap);
        for(Account acct:[SELECT Id,Name,Rating,Phone FROM Account LIMIT 10]){
                    accountWrapper objWrap1 = new accountWrapper(false,acctst);
                objWrap1.accName=acct.Name;
                objWrap1.accPhone=acct.Phone;
                objWrap1.accRating=acct.Rating;
                    wrapAcnts.add(objWrap1);

        }}
        public void displayacnts(){
            for(accountWrapper acct : wrapAcnts ){
            if(acct.checkbox==True){
                wrapAcntssel.add(acct);
                
            }
            }
            
        }
    
     public void delacnts(){
            for(accountWrapper acct : wrapAcnts ){
            if(acct.checkbox==True){
                wrapAcntssel.add(acct);
                
            }
            }}
    public class accountWrapper{
                public Boolean checkbox{get;set;}
        public Account acctst{get;set;}

        public string accName{get;set;}
        public string accPhone{get;set;}
        public string accRating{get;set;}
        public accountWrapper(boolean ckb, Account a){
            this.checkbox=ckb; 
            this.acctst=a;
        }
    }
   
    }