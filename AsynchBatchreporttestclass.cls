@isTest
public class AsynchBatchreporttestclass {


    static testMethod void testmethod1(){
           List<RecordType> recrdtypelist = [SELECT Name, SobjectType,IsPersonType 
                                          FROM RecordType 
                                          WHERE SobjectType='Account' AND IsPersonType=True ];
        
        Lead ld = new Lead(
            LastName = 'TestLead',
            company = 'cc'
            
        );
        insert ld; 
        Account ac = new Account();
        
        ac.FirstName='Firstname';
        ac.LastName='Lastname';
        ac.Salutation='Mr';
        
        
        ac.RecordTypeID=recrdtypelist[0].id;
        insert ac;
        
        Account ac1 = new Account();
        
        ac1.FirstName='Firstname1';
        ac1.LastName='Lastname1';
        
        ac1.Salutation='Mr';
        ac1.Member_Status__pc='Member';
        ac1.RecordTypeID=recrdtypelist[1].id;
        insert ac1;
        Account acc = [Select PersonContactId From Account Where Id = :ac.Id];
        Account acc2 = [Select PersonContactId From Account Where Id = :ac1.Id];
        system.debug('#######'+acc.PersonContactId);
        system.debug('#######'+acc2.PersonContactId);
        Set<ID> idofset = new Set<ID>();
        idofset.add(acc.PersonContactId);
        idofset.add(acc2.PersonContactId);
        List<Contact> cnlst = [Select id, Member_status__c, Status__c,FirstName,LastName,Salutation From Contact Where id IN :idofset and Member_status__c =:'Member' and Status__c = 'Active' ];
        
        
        system.debug('CONSIZE'+cnlst);
        W50_Group__c g = new W50_Group__c(Name = 'Brand 50');
        insert g;
        
        
        Campaign camp1 = new Campaign(
            Name = 'campaign1',
            
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Engage Call').getRecordTypeId(),
            Status = 'Completed',
            Type = 'Virtual Event'
        );
        //   insert camp1;
        
        Campaign camp2 = new Campaign(
            Name = 'campaign2',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('One Degree').getRecordTypeId(),
            Status = 'Completed',
            Type = 'Virtual Event'
        );
        //  insert camp2;
        
        
        Campaign camp3 = new Campaign(
            Name = 'campaign3',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Roundtable').getRecordTypeId(),
            Status = 'Completed',
            Type = 'In Person Event',
            Primary_Group__c=g.id,
            Start_Date_Time__c=datetime.newInstance(2014, 9, 1),
            End_Date_Time__c=datetime.newInstance(2014, 9, 1),
            Date_Time_Status__c='Date & Time TBD',
            Timezone__c='GMT',
            
            Member_Facing_Location__c='TR50 September 2018 LRTP',
            Member_Facing_Title__c='TBD',
            COA_Experience_Code__c='LRTP'
        );
        //  insert camp3;
        Campaign camp4 = new Campaign(
            Name = 'campaign4',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Summit').getRecordTypeId(),
            Status = 'Completed',
            Type = 'Virtual Event'
            
        );
        //  insert camp4;
        Campaign camp5 = new Campaign(
            Name = 'campaign5',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('World 50 Inside Program').getRecordTypeId(),
            Status = 'Completed',
            Type = 'In Person Event',
            Primary_Group__c=g.id,
            Start_Date_Time__c=datetime.newInstance(2014, 9, 1),
            End_Date_Time__c=datetime.newInstance(2014, 9, 1),
            Date_Time_Status__c='Date & Time TBD',
            Timezone__c='GMT',
            
            Member_Facing_Location__c='TR50 September 2018 LRTP',
            Member_Facing_Title__c='TBD',
            COA_Experience_Code__c='LRTP'
        );
        //  insert camp5;
        Campaign camp6 = new Campaign(
            Name = 'campaign6',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Special Program').getRecordTypeId(),
            Status = 'Completed',
            Type = 'Virtual Event',
            Primary_Group__c=g.id,
            Start_Date_Time__c=datetime.newInstance(2014, 9, 1),
            End_Date_Time__c=datetime.newInstance(2014, 9, 1),
            Date_Time_Status__c='Date & Time TBD',
            Timezone__c='GMT',
            
            Member_Facing_Location__c='TR50 September 2018 LRTP',
            Member_Facing_Title__c='TBD',
            COA_Experience_Code__c='LRTP'
        );
        //   insert camp6;
        Campaign camp7 = new Campaign(
            Name = 'campaign7',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Engage Call').getRecordTypeId(),
            
            Status = 'Completed',
            Type = 'In Person Event'
        );
        //  insert camp7;
        Campaign camp8 = new Campaign(
            Name = 'campaign8',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('One Degree').getRecordTypeId(),
            Status = 'Completed',
            Type = 'In Person Event'
        );
        //  insert camp8;
        Campaign camp9 = new Campaign(
            Name = 'campaign9',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Roundtable').getRecordTypeId(),
            Status = 'Completed',
            Type = 'In Person Event',
            Primary_Group__c=g.id,
            Start_Date_Time__c=datetime.newInstance(2014, 9, 1),
            End_Date_Time__c=datetime.newInstance(2014, 9, 1),
            Date_Time_Status__c='Date & Time TBD',
            Timezone__c='GMT',
            
            Member_Facing_Location__c='TR50 September 2018 LRTP',
            Member_Facing_Title__c='TBD',
            COA_Experience_Code__c='LRTP'
        );
        //  insert camp9;
        Campaign camp10 = new Campaign(
            Name = 'campaign10',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Summit').getRecordTypeId(),
            Status = 'Completed',
            Type = 'In Person Event'
        );
        //   insert camp10;
        Campaign camp11 = new Campaign(
            Name = 'campaign11',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('World 50 Inside Program').getRecordTypeId(),
            Status = 'Completed',
            Type = 'In Person Event',
            Primary_Group__c=g.id,
            Start_Date_Time__c=datetime.newInstance(2014, 9, 1),
            End_Date_Time__c=datetime.newInstance(2014, 9, 1),
            Date_Time_Status__c='Date & Time TBD',
            Timezone__c='GMT',
            
            Member_Facing_Location__c='TR50 September 2018 LRTP',
            Member_Facing_Title__c='TBD',
            COA_Experience_Code__c='LRTP'
        );
        //  insert camp11;
        Campaign camp12 = new Campaign(
            Name = 'campaign12',
            IsActive = TRUE,
            RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Special Program').getRecordTypeId(),
            Status = 'Completed',
            Type = 'In Person Event',
            Primary_Group__c=g.id,
            Start_Date_Time__c=datetime.newInstance(2014, 9, 1),
            End_Date_Time__c=datetime.newInstance(2014, 9, 1),
            Date_Time_Status__c='Date & Time TBD',
            Timezone__c='GMT',
            
            Member_Facing_Location__c='TR50 September 2018 LRTP',
            Member_Facing_Title__c='TBD',
            COA_Experience_Code__c='LRTP'
        );
        // insert camp12;
        List<Campaign> campainlist = new List<Campaign>();
        
        campainlist.add(camp6);
        
        campainlist.add(camp1);
        campainlist.add(camp2);
        campainlist.add(camp3);
        campainlist.add(camp4);
        campainlist.add(camp5);
        campainlist.add(camp7);
        campainlist.add(camp8);
        campainlist.add(camp9);
        campainlist.add(camp10);
        campainlist.add(camp11);
        campainlist.add(camp12);
        insert campainlist;
        
        CampaignMemberStatus cms1 = new CampaignMemberStatus(CampaignId=camp1.Id, HasResponded=true, Label='Attended', SortOrder=2);
        CampaignMemberStatus cms2 = new CampaignMemberStatus(CampaignId=camp2.Id, HasResponded=True, Label='Attended', SortOrder=3);
        CampaignMemberStatus cms3 = new CampaignMemberStatus(CampaignId=camp3.Id, HasResponded=True, Label='Attended', SortOrder=4);    
        //update cms1;
        //List<CampaignMemberStatus> cmslist = new  List<CampaignMemberStatus>();
        // cmslist.add(cms1);
        // cmslist.add(cms2);
        // cmslist.add(cms3);
        // insert cmslist;
        
        
        
        CampaignMember capMember1 = new CampaignMember();
        capMember1.CampaignId = camp1.Id;
        capMember1.ContactId=acc.PersonContactId;
        capMember1.LeadId = ld.Id;
        capMember1.Meeting_Day_1__c = 1;
        capMember1.Meeting_Day_2__c = 0;
        capMember1.Dinner_Day_1__c = 1;
        capMember1.Optional_Program__c = 1;
        
        capMember1.Send_SMS__c = false;
        
       capMember1.Status= 'RSVP Yes';
        
        
         //insert capMember1;
        
        CampaignMember capMember2 = new CampaignMember();
        capMember2.CampaignId = camp2.Id;
        capMember2.ContactId=acc.PersonContactId;
        capMember2.LeadId = ld.Id;
        capMember2.Meeting_Day_1__c = 1;
        capMember2.Meeting_Day_2__c = 0;
        capMember2.Dinner_Day_1__c = 1;
        capMember2.Optional_Program__c = 1;
        
        capMember2.Send_SMS__c = false;
        
        capMember2.Status= 'Nominated Topic';
        // insert capMember2;
        CampaignMember capMember3 = new CampaignMember();
        capMember3.ContactId=acc.PersonContactId;
        capMember3.CampaignId = camp3.Id;
        capMember3.LeadId = ld.Id;
        capMember3.Meeting_Day_1__c = 1;
        capMember3.Meeting_Day_2__c = 0;
        capMember3.Dinner_Day_1__c = 1;
        capMember3.Optional_Program__c = 1;
        
        capMember3.Send_SMS__c = false;
        
        capMember3.Status= 'Member Answered via Email';
        // insert capMember3;
        CampaignMember capMember4 = new CampaignMember();
        capMember4.CampaignId = camp4.Id;
        capMember4.LeadId = ld.Id;
        capMember4.ContactId=acc.PersonContactId;
        capMember4.Meeting_Day_1__c = 1;
        capMember4.Meeting_Day_2__c = 0;
        capMember4.Dinner_Day_1__c = 1;
        capMember4.Optional_Program__c = 1;
        
        capMember4.Send_SMS__c = false;
        
        capMember4.Status= 'Attended';
        // insert capMember4;
        CampaignMember capMember5 = new CampaignMember();
        capMember5.CampaignId = camp5.Id;
        capMember5.LeadId = ld.Id;
        capMember5.ContactId=acc.PersonContactId;
        capMember5.Meeting_Day_1__c = 1;
        capMember5.Meeting_Day_2__c = 0;
        capMember5.Dinner_Day_1__c = 1;
        capMember5.Optional_Program__c = 1;
        
        capMember5.Send_SMS__c = false;
        
        capMember5.Status= 'Attended';
        // insert capMember5;
        CampaignMember capMember6 = new CampaignMember();
        capMember6.CampaignId = camp6.Id;
        capMember6.ContactId=acc.PersonContactId;
        capMember6.LeadId = ld.Id;
        capMember6.Meeting_Day_1__c = 1;
        capMember6.Meeting_Day_2__c = 0;
        capMember6.Dinner_Day_1__c = 1;
        capMember6.Optional_Program__c = 1;
        
        capMember6.Send_SMS__c = false;
        
        capMember6.Status= 'Attended';
        // insert capMember6;
        CampaignMember capMember12 = new CampaignMember();
        capMember12.CampaignId = camp12.Id;
        capMember12.LeadId = ld.Id;
        capMember12.Meeting_Day_1__c = 1;
        capMember12.ContactId=acc.PersonContactId;
        capMember12.Meeting_Day_2__c = 0;
        capMember12.Dinner_Day_1__c = 1;
        capMember12.Optional_Program__c = 1;
        
        capMember12.Send_SMS__c = false;
        
        capMember12.Status= 'Attended';
        //   insert capMember12;
        CampaignMember capMember7 = new CampaignMember();
        capMember7.CampaignId = camp7.Id;
        capMember7.LeadId = ld.Id;
        capMember7.Meeting_Day_1__c = 1;
        capMember7.Meeting_Day_2__c = 0;
        capMember7.ContactId=acc.PersonContactId;
        capMember7.Dinner_Day_1__c = 1;
        capMember7.Optional_Program__c = 1;
        
        capMember7.Send_SMS__c = false;
        
        capMember7.Status= 'Attended';
        //  insert capMember7;
        CampaignMember capMember8 = new CampaignMember();
        capMember8.CampaignId = camp8.Id;
        capMember8.LeadId = ld.Id;
        capMember8.Meeting_Day_1__c = 1;
        capMember8.Meeting_Day_2__c = 0;
        capMember8.Dinner_Day_1__c = 1;
        capMember8.Optional_Program__c = 1;
        
        capMember8.Send_SMS__c = false;
        
        capMember8.Status= 'Attended';
        // insert capMember8;
        CampaignMember capMember9 = new CampaignMember();
        capMember9.CampaignId = camp9.Id;
        capMember9.ContactId=acc.PersonContactId;
        capMember9.LeadId = ld.Id;
        capMember9.Meeting_Day_1__c = 1;
        capMember9.Meeting_Day_2__c = 0;
        capMember9.Dinner_Day_1__c = 1;
        capMember9.Optional_Program__c = 1;
        
        capMember9.Send_SMS__c = false;
        
        capMember9.Status= 'Attended';
        //   insert capMember9;
        CampaignMember capMember10 = new CampaignMember();
        capMember10.CampaignId = camp10.Id;
        capMember10.LeadId = ld.Id;
        capMember10.ContactId=acc.PersonContactId;
        capMember10.Meeting_Day_1__c = 1;
        capMember10.Meeting_Day_2__c = 0;
        capMember10.Dinner_Day_1__c = 1;
        capMember10.Optional_Program__c = 1;
        
        capMember10.Send_SMS__c = false;
        
        capMember10.Status= 'Attended';
        //     insert capMember10;
        CampaignMember capMember11 = new CampaignMember();
        capMember11.CampaignId = camp11.Id;
        capMember11.LeadId = ld.Id;
        capMember11.Meeting_Day_1__c = 1;
        capMember11.ContactId=acc.PersonContactId;
        capMember11.Meeting_Day_2__c = 0;
        capMember11.Dinner_Day_1__c = 1;
        capMember11.Optional_Program__c = 1;
        
        capMember11.Send_SMS__c = false;
        
        capMember11.Status= 'Attended';
        
        //  insert capMember11;        
        
     
        

        //insert capMember;
        
        List<CampaignMember> capMemberlist = new List<CampaignMember>();
        capMemberlist.add(capMember1);
        capMemberlist.add(capMember2);
        capMemberlist.add(capMember3);
        capMemberlist.add(capMember4);
        capMemberlist.add(capMember5);
        capMemberlist.add(capMember6); 
        capMemberlist.add(capMember7);
        capMemberlist.add(capMember8);
        capMemberlist.add(capMember9);
        capMemberlist.add(capMember10);
        capMemberlist.add(capMember11);
        capMemberlist.add(capMember12);
        
        
        insert capMemberlist;
        
           capMember1.Status= 'RSVP Yes';
        update capMember1;
        system.debug('+++++STATUS'+ capMember1.Status);
                CampaignMemberStatus newStatus = new CampaignMemberStatus(
    CampaignID=camp1.id,
    Label='RSVP Yes',
    IsDefault=false,
    HasResponded=true,
    SortOrder=3
);
        
        

insert newStatus;
        
        
        CampaignMemberStatus cms = new CampaignMemberStatus(CampaignId=camp1.Id, HasResponded=True, Label='Attended', SortOrder=4);
        insert cms;
        Opportunity o = new Opportunity();
        
        o.Name = 'TestOpp';
        o.Type = 'New';
        o.Person__c=acc.PersonContactId;
        o.StageName = 'On Hold';
        o.CloseDate = system.today();
        o.W50_Group__c = g.Id;
        o.Term_Start_Date__c = Date.newInstance(2011, 05, 01);
        o.Term_End_Date__c = Date.newInstance(2018, 01, 31);
        System.debug('created opportunity');
        
        Connection_Details__c cdc = new Connection_Details__c();
        cdc.Name='connection1';
        cdc.status__c='Completed';
        cdc.Topic__c='Topictest';
        cdc.Source__c='Member Request';
        cdc.Type__c='Member to Member';
        cdc.Category__c='Email';
        cdc.Source_Group__c=g.id;
        
        insert cdc;
        
        
        Connection_Details__c cdc1 = new Connection_Details__c();
        cdc1.Name='connection1';
        cdc1.status__c='Completed';
        cdc1.Topic__c='Topictest';
        cdc1.Source__c='Member Request';
        cdc1.Type__c='Member to Advisor';
        cdc1.Category__c='Email';
        cdc1.Source_Group__c=g.id;
        
        insert cdc1;
        
        Connection_Details__c cdc2 = new Connection_Details__c();
        cdc2.Name='connection1';
        cdc2.status__c='Completed';
        cdc2.Topic__c='Topictest';
        cdc2.Source__c='Member Request';
        cdc2.Type__c='Team to Team';
        cdc2.Category__c='Email';
        cdc2.Source_Group__c=g.id;
        
        insert cdc2;
        
        Connection_Details__c cdc3 = new Connection_Details__c();
        cdc3.Name='connection1';
        cdc3.status__c='Completed';
        cdc3.Topic__c='Topictest';
        cdc3.Source__c='Member Request';
        cdc3.Type__c='Member to Executive Advisor';
        cdc3.Category__c='Email';
        cdc3.Source_Group__c=g.id;
        
        insert cdc3;
        Connection_Details__c cdc4 = new Connection_Details__c();
        cdc4.Name='connection1';
        cdc4.status__c='Completed';
        cdc4.Topic__c='Topictest';
        cdc4.Source__c='Member Request';
        cdc4.Type__c='Member to Prospect';
        cdc4.Category__c='Email';
        cdc4.Source_Group__c=g.id;
        
        insert cdc4;
        
        
        Connection_Relationship__c crc= new Connection_Relationship__c();
        crc.Connection_Name__c=cdc.id;
        crc.Contact__c=acc.PersonContactId;
        insert crc;
        Connection_Relationship__c crc1= new Connection_Relationship__c();
        crc1.Connection_Name__c=cdc1.id;
        crc1.Contact__c=acc.PersonContactId;
        insert crc1;
        Connection_Relationship__c crc2= new Connection_Relationship__c();
        crc2.Connection_Name__c=cdc2.id;
        crc2.Contact__c=acc.PersonContactId;
        insert crc2;
        Connection_Relationship__c crc3= new Connection_Relationship__c();
        crc3.Connection_Name__c=cdc3.id;
        crc3.Contact__c=acc.PersonContactId;
        insert crc3;
        Connection_Relationship__c crc4= new Connection_Relationship__c();
        crc4.Connection_Name__c=cdc4.id;
        crc4.Contact__c=acc.PersonContactId;
        insert crc4;
        
        //Event appointmentKept = new Event(Type = 'Meeting', subject = 'Meeting',ActivityDateTime=date.valueOf('2017-08-08'),DurationInMinutes=5,,OwnerId=UserInfo.getUserId(),RecurrenceStartDateTime=date.valueOf('2017-08-08'),RecurrenceEndDateOnly=date.valueOf('2019-08-08'),WhatId=acc.id);
        //  insert appointmentKept;
        Event newEvent = new Event();
        newEvent.OwnerId = UserInfo.getUserId();
        newEvent.Subject ='Test';
        newEvent.WhoId = acc.PersonContactId;
        newEvent.WhatId = acc.id;
        newEvent.Type = 'Meeting';
        newEvent.IsRecurrence = true;
        newEvent.RecurrenceStartDateTime = System.today();
        newEvent.RecurrenceEndDateOnly = System.today()+30;
        newEvent.RecurrenceType = 'RecursDaily';
        newEvent.RecurrenceInterval = 1; // This means that the event will wait 1 day before recurring again
        newEvent.IsAllDayEvent =true;
        newEvent.DurationInMinutes =1440;
        newEvent.ActivityDate = System.today();
       insert newEvent;
        
        Event newEvent1 = new Event();
        newEvent1.OwnerId = UserInfo.getUserId();
        newEvent1.Subject ='Test';
        newEvent1.WhoId = acc.PersonContactId;
        newEvent1.WhatId = acc.id;
        newEvent1.Type = 'New Member Call';
        newEvent1.IsRecurrence = true;
        newEvent1.RecurrenceStartDateTime = System.today();
        newEvent1.RecurrenceEndDateOnly = System.today()+30;
        newEvent1.RecurrenceType = 'RecursDaily';
        newEvent1.RecurrenceInterval = 1; // This means that the event will wait 1 day before recurring again
        newEvent1.IsAllDayEvent =true;
        newEvent1.DurationInMinutes =1440;
        newEvent1.ActivityDate = System.today();
       insert newEvent1;
        Opportunity opportunity_Obj1 = new Opportunity();
        opportunity_Obj1.RecordTypeId = '012400000001AxBAAU';
        opportunity_Obj1.IsPrivate = false; 
        opportunity_Obj1.CampaignId=camp1.id;
        opportunity_Obj1.Name = 'Name646'; 
        opportunity_Obj1.StageName = 'Prospect Validated';
        opportunity_Obj1.CloseDate = Date.newInstance(2017, 7, 10);
        opportunity_Obj1.Type = 'Renewal';  
        opportunity_Obj1.Person__c=acc.PersonContactId;
        // opportunity_Obj1.Person__c=cnlst[0].id;
        opportunity_Obj1.Renewal_Opps__c = 40;
        opportunity_Obj1.Transferred_From_Type__c='';        
        opportunity_Obj1.Temporarily_Allow_Duplidate__c = false; 
        opportunity_Obj1.Alumni_Re_join__c = false;
        opportunity_Obj1.Use_For_Update__c = false; 
        opportunity_Obj1.Winback_Opportunity__c = false; 
        opportunity_Obj1.At_Risk__c = false;
        opportunity_Obj1.invoiceit_crmx__Create_Order__c = false; 
        opportunity_Obj1.Won_Lost_Reason_Explanation__c='test reason';
        
        //  opportunity_Obj1.Member_status__c='Member';
        //opportunity_Obj1.Person__r.Status__c='Active';
        
        
        opportunity_Obj1.Type = 'Renewal';
        
        opportunity_Obj1.Person__c=acc.PersonContactId;
        
        //opportunity_Obj1.Person__r.FirstName=ac.FirstName;
        //opportunity_Obj1.Person__r.LastName=ac.LastName;
        
        
        
        opportunity_Obj1.CloseDate = system.today();
        opportunity_Obj1.W50_Group__c = g.Id;
        opportunity_Obj1.Term_Start_Date__c = Date.newInstance(2011, 05, 01);
        opportunity_Obj1.Term_End_Date__c = Date.newInstance(2018, 01, 31);
        
        
        
        
        insert opportunity_Obj1;
        opportunity_Obj1.StageName = 'Renewal Declined';
        update opportunity_Obj1;
        Opportunity opportunity_Obj3 = new Opportunity();
        opportunity_Obj3.RecordTypeId = '012400000001AxBAAU';
        opportunity_Obj3.CampaignId=camp1.id;
        opportunity_Obj3.IsPrivate = false; 
        opportunity_Obj3.Name = 'Name646'; 
        opportunity_Obj3.StageName = 'Renewal Rejoin';
        opportunity_Obj3.CloseDate = Date.newInstance(2017, 7, 10);
        opportunity_Obj3.Type = 'Closed Won';  
        opportunity_Obj3.Renewal_Opps__c = 40;
        opportunity_Obj3.Renewed_From__c=opportunity_Obj1.id;
        opportunity_Obj3.Temporarily_Allow_Duplidate__c = false; 
        opportunity_Obj3.Alumni_Re_join__c = false;
        opportunity_Obj3.Use_For_Update__c = false; 
        opportunity_Obj3.Transferred_From_Type__c='Group Transfer';
        opportunity_Obj3.Winback_Opportunity__c = false; 
        opportunity_Obj3.At_Risk__c = false;
        opportunity_Obj3.invoiceit_crmx__Create_Order__c = false; 
        opportunity_Obj3.Won_Lost_Reason_Explanation__c='test reason';
        opportunity_Obj3.Renewal_Opp__c=opportunity_Obj1.id;
        Opportunity opportunity_Obj4 = new Opportunity();
        opportunity_Obj4.RecordTypeId = '012400000001AxBAAU';
        opportunity_Obj4.IsPrivate = false; 
        opportunity_Obj4.CampaignId=camp1.id;
        opportunity_Obj4.Name = 'Name646'; 
        opportunity_Obj4.StageName = 'Renewal Rejoin';
        opportunity_Obj4.CloseDate = Date.newInstance(2017, 7, 10);
        opportunity_Obj4.Type = 'Closed Won';  
        opportunity_Obj4.Renewal_Opps__c = 40;
        opportunity_Obj4.Renewed_From__c=opportunity_Obj1.id;
        opportunity_Obj4.Temporarily_Allow_Duplidate__c = false; 
        opportunity_Obj4.Alumni_Re_join__c = false;
        opportunity_Obj4.Use_For_Update__c = false; 
        opportunity_Obj4.Transferred_From_Type__c='';
        opportunity_Obj4.Winback_Opportunity__c = false; 
        opportunity_Obj4.At_Risk__c = false;
        opportunity_Obj4.invoiceit_crmx__Create_Order__c = false; 
        opportunity_Obj4.Won_Lost_Reason_Explanation__c='test reason';
        List<Opportunity> opportunity_Objrenew = new  List<Opportunity>();
        List<Opportunity> opportunity1_Objrenew = new  List<Opportunity>();
        opportunity_Objrenew.add(opportunity_Obj3);
        opportunity_Objrenew.add(opportunity_Obj4);
        insert  opportunity_Objrenew;        
        
        //Now update the OCR for the primary contact
        OpportunityContactRole ocr = new OpportunityContactRole();
        ocr.ContactId = acc.PersonContactId;
        ocr.OpportunityId = opportunity_Obj1.Id;
        ocr.IsPrimary = TRUE;
        ocr.Role = 'Decision Maker';
        insert ocr;
        System.debug('created opportunity contact role for primary');
        
        //Now update the OCR for the non-primary contact
        OpportunityContactRole ocr1 = new OpportunityContactRole();
        
        ocr1.ContactId = acc2.PersonContactId;
        ocr1.OpportunityId = opportunity_Obj1.Id;
        ocr1.IsPrimary = FALSE;
        ocr1.Role = 'Decision Maker';
        insert ocr1;
        update opportunity_Obj1;
        
        List<Contact> conlist =[SELECT Name, Email, Account.Name,(SELECT HasResponded, status,Campaign.Name,Contact.Name,Campaign.RecordTypeID,Campaign.Type,Campaign.Status  FROM CampaignMembers),(SELECT Opportunity.Person__c,Opportunity.Id,Opportunity.Name,Opportunity.W50_Group__r.Name,Opportunity.Person__r.Salutation,Opportunity.Person__r.FirstName,Opportunity.Person__r.LastName,Opportunity.Renewal_Opp__r.Name,Opportunity.Person__r.Person_Mailing_Region__c,Opportunity.Type,Opportunity.Renewal_Count__c,Opportunity.Term_Start_Date__c,Opportunity.Term_End_Date__c,Opportunity.Term_Actual_Months__c,Opportunity.Term_Amount__c,Opportunity.Renewal_Opp_Amount__c,Opportunity.Actual_Close_Date__c,Opportunity.Won_Lost_Reason__c,Opportunity.Renewal_Opp_Won_Loss_Reason__c ,Opportunity.Renewal_Opp_Stage__c,Opportunity.StageName  FROM OpportunityContactRoles) FROM Contact where id =:acc.PersonContactId limit 100];
        system.debug('##CONLIST'+conlist.size()); 
        List<String> conidlst = new List<String>();
        for(Contact c:conlist)
        {
           conidlst.add(c.id); 
        }
        Opportunity_Report__c report = new Opportunity_Report__c();
        report.Name = 'Opportunity Report' + datetime.now();
        insert report ;
       
           ID batchId = System.enqueueJob(new AsyncBatchreport(0,1,conidlst,report.id));
    }
}