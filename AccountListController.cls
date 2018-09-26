public class AccountListController {
 private final Account acct;
public string cid{get;set;}
    public AccountListController(ApexPages.StandardController controller) {

    this.acct = (Account)controller.getRecord();
    Account a = [select ContactID__c from Account where id =:acct.id];
    
    cid = a.ContactID__c;
    }
    public PageReference getimage(){
    return new Pagereference('/apex/imageUploadCampaign?id='+cid+'&object=pa');
    }
 private final ApexPages.StandardController controller;
 
}