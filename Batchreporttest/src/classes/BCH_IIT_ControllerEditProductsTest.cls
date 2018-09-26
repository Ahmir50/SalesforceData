@isTest
public class  BCH_IIT_ControllerEditProductsTest{
    @testsetup
    public static void dataSetup() {
       
        
        
        Account account = new Account(Name = 'Test Account',Type = 'Partner');
        insert account;
        
        invoiceit_s__Currency__c curr = new invoiceit_s__Currency__c(Name = 'USD',invoiceit_s__Currency_Symbol__c='$');
        insert curr;
        
        Contact contact =  new Contact(LastName = 'Mccage1',accountId = account.Id,email='ram@invoiceit.com');
        insert contact;
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User userToCreate = new User();
        
        // Do you recognize these fields?
        userToCreate.FirstName = 'David';
        userToCreate.LastName  = 'Liu';
        userToCreate.Email     = 'dvdkliu+sfdc99@gmail.com';
        userToCreate.Username  = 'sfdc-dreamertest123@gmail.com';
        userToCreate.Alias     = 'fatty';
        userToCreate.ProfileId = p.id;
        
        // Don't worry about these
        userToCreate.TimeZoneSidKey    = 'America/Denver';
        userToCreate.LocaleSidKey      = 'en_US';
        userToCreate.EmailEncodingKey  = 'UTF-8';
        userToCreate.LanguageLocaleKey = 'en_US';
        
        insert userToCreate;
        
        W50_Group__c wsGroup = new W50_Group__c();
        wsGroup.Group_Name_Short__c = 'test';
        wsGroup.COA_Group_Code__c = 'tes4';
        wsGroup.Group_Director__c = userToCreate.id;
        wsGroup.Group_Director_Contact__c = contact.id;
        wsGroup.Member_Services_Associate__c = userToCreate.id;
        wsGroup.Member_Services_Associate_Contact__c = contact.id;
        
        insert wsGroup;
        
        W50_Group__c wsGroup1 = new W50_Group__c();
        wsGroup1.Group_Name_Short__c = 'test';
        wsGroup1.COA_Group_Code__c = 'kes4';
        wsGroup1.Group_Director__c = userToCreate.id;
        wsGroup1.Group_Director_Contact__c = contact.id;
        wsGroup1.Member_Services_Associate__c = userToCreate.id;
        wsGroup1.Member_Services_Associate_Contact__c = contact.id;
        
        insert wsGroup1;
        
        
        
        
        
        invoiceit_s__Product__c product = new  invoiceit_s__Product__c(Name = 'Test Product',W50_Group__c = wsGroup.id,
                                                                       invoiceit_s__Valid_From_Date__c = Date.today(),
                                                                       invoiceit_s__Valid_To_Date__c = Date.today()+90,
                                                                       invoiceit_s__Product_Family__c = 'Default',
                                                                       invoiceit_s__Product_Code__c = 'Code1',
                                                                       invoiceit_s__Description__c = 'Product'
                                                                      );
        insert product;
        
        invoiceit_s__Product_Rate_Plan__c productRatePlan = new  invoiceit_s__Product_Rate_Plan__c(Name = 'Test ProductRatePlan',
                                                                                                   invoiceit_s__Product__c = product.Id,
                                                                                                   invoiceit_s__Valid_From_Date__c = Date.today(),
                                                                                                   invoiceit_s__Valid_To_Date__c = Date.today()+90
                                                                                                  );
        insert productRatePlan;
        
        list<invoiceit_s__Product_Rate_Plan_Charge__c> listProductRatePlanCharges = new list<invoiceit_s__Product_Rate_Plan_Charge__c>();       
        invoiceit_s__Product_Rate_Plan_Charge__c productRatePlanCharge = new invoiceit_s__Product_Rate_Plan_Charge__c(Name = 'Setup Charges',
                                                                                                                      invoiceit_s__CurrencyL__c = curr.Id,
                                                                                                                      invoiceit_s__Product_Rate_Plan__c = productRatePlan.Id,
                                                                                                                      invoiceit_s__Unit_Price__c = 1000,
                                                                                                                      invoiceit_s__Cost_Price__c = 500,                                                                  
                                                                                                                      invoiceit_s__Price_Type__c = 'One Time'      
                                                                                                                     );
        
        
        listProductRatePlanCharges.add(productRatePlanCharge);
        
        insert listProductRatePlanCharges;
        
        invoiceit_s__Product__c product1 = new  invoiceit_s__Product__c(Name = 'Co-Host Fee',W50_Group__c = wsGroup1.id,
                                                                        invoiceit_s__Valid_From_Date__c = Date.today(),
                                                                        invoiceit_s__Valid_To_Date__c = Date.today()+90,
                                                                        invoiceit_s__Product_Family__c = 'Default',
                                                                        invoiceit_s__Product_Code__c = 'Code1',
                                                                        invoiceit_s__Description__c = 'Product'
                                                                       );
        insert product1;
        
        invoiceit_s__Product_Rate_Plan__c productRatePlan1 = new  invoiceit_s__Product_Rate_Plan__c(Name = 'Test ProductRatePlan',
                                                                                                    invoiceit_s__Product__c = product1.Id,
                                                                                                    invoiceit_s__Valid_From_Date__c = Date.today(),
                                                                                                    invoiceit_s__Valid_To_Date__c = Date.today()+90
                                                                                                   );
        insert productRatePlan1;
        
        list<invoiceit_s__Product_Rate_Plan_Charge__c> listProductRatePlanCharges1 = new list<invoiceit_s__Product_Rate_Plan_Charge__c>();       
        invoiceit_s__Product_Rate_Plan_Charge__c productRatePlanCharge1 = new invoiceit_s__Product_Rate_Plan_Charge__c(Name = 'Setup Charges',
                                                                                                                       invoiceit_s__CurrencyL__c = curr.Id,
                                                                                                                       invoiceit_s__Product_Rate_Plan__c = productRatePlan1.Id,
                                                                                                                       invoiceit_s__Unit_Price__c = 1000,
                                                                                                                       invoiceit_s__Cost_Price__c = 500,                                                                  
                                                                                                                       invoiceit_s__Price_Type__c = 'One Time'      
                                                                                                                      );
        
        
        listProductRatePlanCharges1.add(productRatePlanCharge1);
        
        insert listProductRatePlanCharges1;
        
        test.starttest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Opportunity; 
        Map<String,Schema.RecordTypeInfo> oppRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        
        Opportunity opp = new Opportunity(StageName = 'One', Name = 'Opp', AccountId = account.Id,invoiceit_crmx__CurrencyL__c = curr.Id);
        opp.W50_Group__c = wsGroup.id;
        opp.Person__c= contact.id;
        opp.Member_Type__c = 'Practitioner';
        opp.Proposed_Start_Date__c = date.newinstance(2018,5,1);
        opp.Proposed_Term__c = 12;
        opp.MD_Leader__c = 'Jeff Shulman';
        opp.Opportunity_Source_Contact__c =contact.id; 
        opp.Won_Lost_Reason_Explanation__c = 'test ';
        opp.Won_Lost_Action__c = 'Call 1';
        opp.Won_Lost_Reason__c = 'Overall World 50 Value Proposition';
        opp.of_Invoices__c = 2;
        opp.CloseDate = system.today();
        opp.Type = 'Renewal';
        opp.StageName='Renewal Pending';
        opp.recordtypeid =  oppRecordTypeInfo.get('New Membership').getRecordTypeId();
        opp.invoiceit_crmx__CurrencyL__c = curr.id;
        opp.invoiceit_crmx__Total__c =73000;
        
        insert opp;
         ApexPages.StandardController controller = new ApexPages.StandardController(opp);
        IIT_ControllerEditProducts controllerEditProducts =  new IIT_ControllerEditProducts(controller);
        
        list<invoiceit_crmx__Opportunity_Rate_Plan_Charge__c> oppCharges = controllerEditProducts.oppCharges;
        
        for(invoiceit_crmx__Opportunity_Rate_Plan_Charge__c  charge : controllerEditProducts.oppCharges){
            charge.invoiceit_crmx__Discount_Value__c = 0;
            charge.Granted_By_User__c = userToCreate.id;
            charge.Notes__c = 'test';
            charge.Discount_Reason__c = 'test';
            charge.invoiceit_crmx__Quantity__c = null;
            charge.invoiceit_crmx__Unit_Price__c =73000;       }
        Pagereference ref =  controllerEditProducts.saveCharges();
        
        for(invoiceit_crmx__Opportunity_Rate_Plan_Charge__c  charge : controllerEditProducts.oppCharges){
            charge.invoiceit_crmx__Discount_Value__c = 100;
            charge.Granted_By_User__c = null;
            charge.Discount_Reason__c = null;
            charge.Notes__c = null;
            
        }
        Pagereference ref1 =  controllerEditProducts.saveCharges();
        for(invoiceit_crmx__Opportunity_Rate_Plan_Charge__c  charge : controllerEditProducts.oppCharges){
            charge.invoiceit_crmx__Discount_Value__c = 100;
            charge.Granted_By_User__c = userToCreate.id;
            charge.Notes__c = 'test';
        }
        
        Pagereference ref12 =  controllerEditProducts.saveCharges();
        for(invoiceit_crmx__Opportunity_Rate_Plan_Charge__c  charge : controllerEditProducts.oppCharges){
            charge.invoiceit_crmx__Discount_Value__c = 100;
            charge.Granted_By_User__c = null;
            charge.Notes__c = 'test';
            charge.invoiceit_crmx__Unit_Price__c = 1500;
        }
        
        Pagereference ref13 =  controllerEditProducts.saveCharges();
        
        for(invoiceit_crmx__Opportunity_Rate_Plan_Charge__c  charge : controllerEditProducts.oppCharges){
            charge.invoiceit_crmx__Discount_Value__c = 100;
            //charge.Granted_By_User__c = '012376423sd';
            charge.Notes__c = 'test';
            charge.invoiceit_crmx__Unit_Price__c = 73000;
            charge.Discount_Reason__c = 'test';
        }
        Pagereference ref14 =  controllerEditProducts.saveCharges();
    }
    
    public static testMethod void testBatch(){
        
        Batch_Configuration__c bc1 =new Batch_Configuration__c();
        bc1.Name = 'BCH_IIT_ControllerEditProducts';
        bc1.Date_1__c = date.newinstance(2017,5,1);
        bc1.Date_2__c = date.newinstance(2018,12,12);
        insert bc1;
        
         List<invoiceit_crmx__Opportunity_Rate_Plan_Charge__c> crmxopList =[ Select  id, invoiceit_crmx__Unit_Price__c, invoiceit_crmx__Accounting_Code__c,Name,invoiceit_crmx__Opportunity_Rate_Plan__r.Name, invoiceit_crmx__Opportunity__r.name, invoiceit_crmx__Opportunity__r.Id, invoiceit_crmx__Opportunity__r.type,invoiceit_crmx__Opportunity__r.Member_Type__c, invoiceit_crmx__Opportunity__r.StageName,invoiceit_crmx__Opportunity__r.Proposed_Start_Date__c
                                                                           FROM invoiceit_crmx__Opportunity_Rate_Plan_Charge__c  
                                                                            WHERE invoiceit_crmx__Opportunity__r.type='Renewal' 
                                                                           and (invoiceit_crmx__Opportunity__r.StageName='Renewal Pending' 
                                                                                 or invoiceit_crmx__Opportunity__r.StageName='Renewal Invoice Held' )];
                                                                           /*  and (invoiceit_crmx__Opportunity__r.Member_Type__c='Practitioner'   
                                                                                 or invoiceit_crmx__Opportunity__r.Member_Type__c='Advising')  
                                                                            and invoiceit_crmx__Opportunity__r.Proposed_Start_Date__c <= :bc1.Date_2__c 
                                                                            and invoiceit_crmx__Opportunity__r.Proposed_Start_Date__c >= :bc1.Date_1__c ]; */
        System.debug(crmxopList.size());
        System.debug(crmxopList);
        
        
        BCH_IIT_ControllerEditProducts batch = new BCH_IIT_ControllerEditProducts();
        //batch.IdToErrorMap.put(UserInfo.getUserId(),'Test');
        Id batchId = database.executeBatch(batch,1);
        
    } 
    
    
    
    
    
}