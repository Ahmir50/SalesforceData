/*
* : BCH_IIT_ControllerEditProducts batch = new BCH_IIT_ControllerEditProducts();
Id batchId = database.executeBatch(batch,1);
|System.EmailException: SendEmail failed. First exception on row 0; first error: NO_MASS_MAIL_PERMISSION, Single email is not enabled for your organization or profile.: []
*/

global class BCH_IIT_ControllerEditProducts implements Database.Batchable <sObject>, Database.Stateful {
    
    Map<ID, String> IdToErrorMap = new Map<Id, String>();
    Batch_Configuration__c bc1 = Batch_Configuration__c.getValues('BCH_IIT_ControllerEditProducts');
    
    /**
* Start Method of Batch.
*/
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        if(bc1 == null) {
            return null;
        }
        
        List<invoiceit_crmx__Opportunity_Rate_Plan_Charge__c> crmxopList =[ Select  id, invoiceit_crmx__Unit_Price__c, invoiceit_crmx__Accounting_Code__c,Name,invoiceit_crmx__Opportunity_Rate_Plan__r.Name, invoiceit_crmx__Opportunity__r.name, invoiceit_crmx__Opportunity__r.Id, invoiceit_crmx__Opportunity__r.type,invoiceit_crmx__Opportunity__r.Member_Type__c, invoiceit_crmx__Opportunity__r.StageName,invoiceit_crmx__Opportunity__r.Proposed_Start_Date__c
                                                                           FROM invoiceit_crmx__Opportunity_Rate_Plan_Charge__c  WHERE invoiceit_crmx__Opportunity__r.type='Renewal' and (invoiceit_crmx__Opportunity__r.StageName='Renewal Pending' or invoiceit_crmx__Opportunity__r.StageName='Renewal Invoice Held' )and (invoiceit_crmx__Opportunity__r.Member_Type__c='Practitioner'   or invoiceit_crmx__Opportunity__r.Member_Type__c='Advising')  and invoiceit_crmx__Opportunity__r.Proposed_Start_Date__c <= :bc1.Date_2__c and invoiceit_crmx__Opportunity__r.Proposed_Start_Date__c >= :bc1.Date_1__c ];
        
        for(invoiceit_crmx__Opportunity_Rate_Plan_Charge__c  oppobj1 : crmxopList) {
            if (oppobj1.invoiceit_crmx__Unit_Price__c!=null) {
                oppobj1.invoiceit_crmx__Unit_Price__c = oppobj1.invoiceit_crmx__Unit_Price__c + 1000;
            }
        }
        update crmxopList;
         System.debug(crmxopList.size());
        
        Set<Id> opportunityIds = new Set<Id>();
        
        for(invoiceit_crmx__Opportunity_Rate_Plan_Charge__c co : crmxopList) {
            opportunityIds.add(co.invoiceit_crmx__Opportunity__c);
        }
        //opportunityIds.add('0064000000pRjDfAAK');
        System.debug(opportunityIds.size());
          System.debug(opportunityIds);
        
        return Database.getQueryLocator([Select  id From Opportunity where Id in :opportunityIds ]);
    }
    
    /**
* Execute Method of Batch.
*/
    global void execute(Database.BatchableContext BC, List < Opportunity > listOfOpps) {
        for(Opportunity  oppobj : listOfOpps){
            
            IIT_ControllerEditProductsBatchHelper bh = new IIT_ControllerEditProductsBatchHelper(oppobj);
            bh.recalculate();
            bh.saveCharges();
            
            if(bh.errorString != null ) {
                IdToErrorMap.put(oppobj.Id, bh.errorString);
            }
            //IdToErrorMap.put('0064000000pRjDfAAK', 'Test Error');
            //IdToErrorMap.put('0064000000pRjDfAAM', 'Test Error');
        }
    }
    
    /**
* Finish Method of Batch.
*/
    global void finish(Database.BatchableContext BC) {
        
        if(IdToErrorMap.size()>0 || Test.isRunningTest()){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject('Updated BCH_IIT_ControllerEditProducts');
            mail.setPlainTextBody('Attached file contains the list of Opp Records that are not updated from batch');
            String body = '';
            
            for(String k : IdToErrorMap.keySet()) {
                body += k + ' --- '+  IdToErrorMap.get(k) + ' \n';
            }
            System.debug(body);
            mail.setPlainTextBody(body);
            mail.setToAddresses(new list<string>{'ahmirtest@gmail.com'});
            if(!Test.isRunningTest()) {
                Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
            }
        }
        
    }
}