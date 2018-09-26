@isTest

private class AccountListControllertest{


  
 @isTest(seealldata=false)    
    public static  void AccountListController_test_method_1() {
         test.startTest();
  
  
   Contact cn = new Contact();
   cn.LastName = 'Contactlast';
   insert cn;
 
 Account ac= new Account();
 ac.Name = 'name1';
    cn.id= ac.ContactID__c;
 insert ac;
  
 ApexPages.StandardController sc = new ApexPages.StandardController(ac);
       
  AccountListController acclis = new  AccountListController(sc);
      PageReference pf = Page.Campaign_Attendeds;
    pf.getParameters().put('id', String.valueOf(ac.Id));
    pf.getParameters().put('object', 'pa');
    Test.setCurrentPage(pf);    
     
    
 acclis.getimage();
        
    test.stopTest();   
    
 
  }
}