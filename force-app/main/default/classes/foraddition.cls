public class foraddition {
    public integer a;
    public integer b;
    public integer ans;
     public integer getans(){
        return ans;
     }
    public void setans(integer ans){
         this.ans = ans;
         
     }
    public integer geta(){
        return a;
    }
public integer getb(){
        return b;
}
    public void seta(integer a){
      this.a = a;
    }
    public void setb(integer b){
      this.b = b;
    }
    public pageReference add(){
        ans=a+b;
        return null;
    }
public pageReference sub(){
        ans=a-b;
        return null;
    }
public pageReference mul(){
        ans=a*b;
        return null;
    }
public pageReference div(){
        ans=a/b;
        return null;
    }

}