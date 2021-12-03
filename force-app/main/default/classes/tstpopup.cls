public with sharing class tstpopup {

    public lead ll { get; set; }
    public Id leadid {get; set;}

 public Boolean displayPopUp { get; set; }
  public List<Lead> leads { get; set; }
    public tstpopup() {
       leads=new List<Lead>();  
       ll=new lead();
       leads=[select Name,Email from Lead];
    }

    public PageReference closePopup() {
        displaypopup=false;
        return null;
    }
    
  public PageReference showPopup() {
    ll =[select Name,Email,company,phone,Country from lead  where id=:leadid];
       displaypopup=true;
        return null;
    }

}