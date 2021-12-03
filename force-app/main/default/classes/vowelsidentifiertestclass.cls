@isTest
private class vowelsidentifiertestclass {
    @isTest static void vowelsMethod(){
        String resultexp = vowelsdentifier.logic('a');
        system.assertEquals('is a vowel', resultexp);
    }  
  @isTest static void notvowelsMethod(){
        String resultexp = vowelsdentifier.logic('s');
        system.assertEquals('is noot a vowel', resultexp);
    }  
}