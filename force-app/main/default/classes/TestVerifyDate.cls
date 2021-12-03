@isTest
public class TestVerifyDate {
    @isTest static void correctdate() {
        Date dategiven = VerifyDate.CheckDates(date.valueOf('2021-05-01'), date.valueOf('2021-05-24'));
        System.assertEquals(date.valueOf('2021-05-24'), dategiven);
           }
     @isTest static void correctdate1() {
        Date dategiven = VerifyDate.CheckDates(date.valueOf('2021-05-01'), date.valueOf('2021-06-06'));
        System.assertEquals(date.valueOf('2021-05-31'), dategiven);
     }
}