public class AccountcurrmemController {
 private final Account acct;
public string aid{get;set;}
    public AccountcurrmemController(ApexPages.StandardController controller) {

    this.acct = (Account)controller.getRecord();
    Account a = [select Account_ID__c from Account where id =:acct.id];
    
    aid = a.Account_ID__c;
    }
    public PageReference getimage(){
    return new Pagereference('/apex/CurrentMembers?id='+aid+'&object=pa');
    }
 private final ApexPages.StandardController controller;
 
}