@isTest
public class testvowelsdentifier {
    @isTest static void testinglogic(){
    string res= vowelsdentifier.logic('o');
        System.assertEquals('is a vowel', res);
        }
@isTest static void testinglogic2(){
    string res= vowelsdentifier.logic('l');
        System.assertEquals('is noot a vowel', res);
        }
}