global class BatchReport implements 
Database.Batchable<sObject>, Database.Stateful {    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;  
    global string csvfile='';
    global List<sObject> start(Database.BatchableContext bc) {
        List<Contact> conlist =[SELECT Name, Email, Account.Name,(SELECT HasResponded, status,Campaign.Name,Contact.Name,Campaign.RecordTypeID,Campaign.Type,Campaign.Status  FROM CampaignMembers),(SELECT Opportunity.Person__c,Opportunity.Id,Opportunity.Name,Opportunity.W50_Group__r.Name,Opportunity.Person__r.Salutation,Opportunity.Person__r.FirstName,Opportunity.Person__r.LastName,Opportunity.Renewal_Opp__r.Name,Opportunity.Person__r.Person_Mailing_Region__c,Opportunity.Type,Opportunity.Renewal_Count__c,Opportunity.Term_Start_Date__c,Opportunity.Term_End_Date__c,Opportunity.Term_Actual_Months__c,Opportunity.Term_Amount__c,Opportunity.Renewal_Opp_Amount__c,Opportunity.Actual_Close_Date__c,Opportunity.Won_Lost_Reason__c,Opportunity.Renewal_Opp_Won_Loss_Reason__c ,Opportunity.Renewal_Opp_Stage__c,Opportunity.StageName  FROM OpportunityContactRoles) FROM Contact limit 50];
        system.debug('##CONLIST'+conlist); 

        return conlist;
    }
   global void execute(Database.BatchableContext bc, List<Contact> conlist){
        
        Map<string,List<Integer>> CampaignRecordTypeMap = new Map<string,List<Integer>>();
        Map<string,Opportunity> oppstrid = new Map<string,Opportunity>();
        List<CampaignMember> camlist = new List<CampaignMember>();
        Map<string,List<String>> OnedegreeMap = new Map<string,List<String>>();
        string Onedegree_request = '';
        string Onedegree_reply = '';
        Integer Engagecallcount = 0;
        Integer OneDegreecount = 0;
        Integer Dinnercount = 0;
        Integer Summitscount = 0;
        Integer W50Programcount = 0;
        Integer W50Special = 0;
        Id EngageCall_rid = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get( 'Engage Call').getRecordTypeId(); 
        Id OneDegre_rid = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('One Degree').getRecordTypeId();
        Id Roundtable_rid = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Roundtable').getRecordTypeId();
        Id Summit_rid = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Summit').getRecordTypeId();
        Id World50insideProgram_rid = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('World 50 Inside Program').getRecordTypeId(); 
        Id SpecialProgram_rid = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Special Program').getRecordTypeId();
        set<ID>  PersonAccountIds = new set<ID>();
        for(Integer i=0;i<conlist.size();i++){
            for(Integer j=0;j<conlist[i].CampaignMembers.size();j++){
                for(Integer k=0;k<conlist[i].OpportunityContactRoles.size();k++){
                PersonAccountIds.add(conlist[i].OpportunityContactRoles[k].Opportunity.Person__C);
                    string opp = conlist[i].OpportunityContactRoles[k].Opportunity.Name;
                    system.debug(conlist[i].CampaignMembers[j].Campaign.Name);
                    //system.debug(conlist[i].CampaignMembers.size());
                    system.debug(conlist[i].OpportunityContactRoles[k].Opportunity.Person__C);
                    system.debug(conlist[i].OpportunityContactRoles[k].Opportunity.Name);
                    camlist = conlist[i].CampaignMembers;
                    
                    system.debug(camlist);
                    
                    
                    for(CampaignMember camp :camlist){
                        if(camp.Campaign.RecordTypeID == EngageCall_rid &&   camp.Campaign.Type == 'Virtual Event' &&   camp.Campaign.Status  =='Completed'  ){
                            system.debug('@@@@ camp.status'+camp.status );
                            if(camp.status == 'RSVP Yes' || camp.status =='Attended'){ 
                                Engagecallcount = Engagecallcount + 1;                   
                            }
                        }
                        /*else if(camp.Campaign.RecordTypeID  == OneDegre_rid && ( camp.Campaign.Type == 'Virtual Event'  ||  camp.Campaign.Type == 'One Degree'  )  &&   camp.Campaign.Status  =='Completed' ){
if(camp.status == 'Nominated Topic' || camp.status =='Member Interview Completed'){
OneDegreecount = OneDegreecount + 1;           
} 
}*/
                        else if(camp.Campaign.RecordTypeID  == OneDegre_rid &&   (camp.Campaign.Type == 'Virtual Event' || camp.Campaign.Type == 'One Degree' ||   camp.Campaign.Status  =='Completed') ){
                           system.debug('@@@@ camp.status'+camp.status );
                            if(camp.status == 'Nominated Topic' ){
                                  system.debug('@@@@ camp.status'+camp.status );
                                //   system.debug('@@@@ Opp2'+Opp2 );
                               // system.debug('@@@@ Onedegree_request'+Onedegree_request);
                                OneDegreecount = OneDegreecount + 1;           
                                 Onedegree_request = camp.status;
                                //   system.debug('@@@@ Onedegree_request'+Onedegree_request);
                            } 
                            if(camp.status == 'Member Answered via Email' || camp.status == 'Member Answered via App' || camp.status == 'Member Answered via Email'){
                                OneDegreecount = OneDegreecount + 1;           
                                 Onedegree_reply = camp.status  ;
                                //  system.debug('@@@@ Onedegree_reply'+Onedegree_reply);
                            } 
                        }
                        else if(camp.Campaign.RecordTypeID  == Roundtable_rid  &&   camp.Campaign.Type == 'In Person Event' &&   camp.Campaign.Status  =='Completed'  ){
                            if(camp.status == 'RSVP Yes' || camp.status =='Attended'){ 
                                Dinnercount = Dinnercount + 1;
                            }
                        }
                        else if(camp.Campaign.RecordTypeID  == Summit_rid  && camp.Campaign.Type == 'In Person Event' &&   camp.Campaign.Status  =='Completed'){
                            if(camp.status == 'RSVP Yes' || camp.status =='Attended'){ 
                                Summitscount = Summitscount + 1;
                            } 
                        }
                        else if(camp.Campaign.RecordTypeID  == World50insideProgram_rid && camp.Campaign.Type == 'In Person Event' &&   camp.Campaign.Status  =='Completed' ) {
                            if(camp.status == 'RSVP Yes' || camp.status =='Attended'){ 
                                W50Programcount = W50Programcount + 1;
                            } 
                        }
                        else if(camp.Campaign.RecordTypeID  == SpecialProgram_rid  && camp.Campaign.Type == 'In Person Event' &&   camp.Campaign.Status  =='Completed'){
                            if(camp.status == 'RSVP Yes' || camp.status =='Attended'){ 
                                W50Special = W50Special + 1;
                            }
                        }
                    }
                    
                    List<Integer> RecordTypeLst = new Integer[6];
                    
                    RecordTypeLst[0] = Engagecallcount;
                    RecordTypeLst[1] = OneDegreecount;
                    RecordTypeLst[2] = Dinnercount;
                    RecordTypeLst[3] = Summitscount;
                    RecordTypeLst[4] = W50Programcount;
                    RecordTypeLst[5] = W50Special;    
                    
                    CampaignRecordTypeMap.put(opp,RecordTypeLst);
                     List<String> onedegreeData =new List<String>();
                    onedegreeData.add(Onedegree_request);                    
                    onedegreeData.add(Onedegree_reply);
                    
                    OnedegreeMap.put(opp,onedegreeData);
                    
                    system.debug('OnedegreeMap : ' + OnedegreeMap);
                    //RecordTypeLst.clear();
                    system.debug('CampaignRecordTypeMap : ' + CampaignRecordTypeMap);
                    Engagecallcount = 0;
                    OneDegreecount = 0;
                    Dinnercount = 0;
                    Summitscount = 0;
                    W50Programcount = 0;
                    W50Special = 0;
                    //system.debug(conlist[i].CampaignMembers[j].Campaign.Name);
                    //system.debug(conlist[i].OpportunityContactRoles[j].Opportunity.Name);
                    oppstrid.put(conlist[i].OpportunityContactRoles[k].Opportunity.Name,conlist[i].OpportunityContactRoles[k].Opportunity);
                    
                    system.debug('oppstrid : ' + oppstrid);
                }
            }
        }
        
        List<Connection_Relationship__c> connectiondetailslist = [select id,Connection_Type__c,Status__c,Contact__r.id,Connection_Name__r.Type__c,Contact__c,Connection_Name__c from Connection_Relationship__c where Status__c = 'Completed' and Contact__c IN :PersonAccountIds and Contact__c != null];
        
        system.debug('connectiondetailslist : ' + connectiondetailslist);
        
        List<string> connectionsnotype = new List<string>{'Member to Delegate','Member to Discussion Leader','Member to Alumni','Alumni to Alumni','Prospect to Advisor','Prospect to Advising Member','EA to EA','Member to Executive Advisor','Alumni to Executive Advisor'};
            
            Map<Id,Connection_Relationship__c> mapofcontandconrelation = new Map<Id,Connection_Relationship__c>();
        for(Connection_Relationship__c connrelcon : connectiondetailslist)
        {
            mapofcontandconrelation.put(connrelcon.Contact__c,connrelcon);
        }
        
        Map<Id,List<Integer>> ConnectionRecordTypeMap = new Map<Id,List<Integer>>();
        
        Integer ConnectionNoType = 0;
        Integer M2M = 0;
        Integer M2Prospect = 0;
        Integer M2Advisor = 0;
        Integer T2T = 0;
        Integer M2EA = 0;
        
        for(Connection_Relationship__c connection : connectiondetailslist)
        {
            if(connectionsnotype.contains(connection.Connection_Type__c))
            {
                ConnectionNoType = ConnectionNoType + 1;
            }
            else if(connection.Connection_Type__c == 'Member to Member')
            {
                M2M = M2M + 1;
            }
            else if(connection.Connection_Type__c == 'Member to Prospect')
            {
                M2Prospect = M2Prospect + 1;
            }
            else if(connection.Connection_Type__c == 'Member to Advisor')
            {
                M2Advisor = M2Advisor + 1;
            }
            else if(connection.Connection_Type__c == 'Team to Team')
            {
                T2T = T2T + 1;
            }
            else if(connection.Connection_Type__c == 'Member to Executive Advisor')
            {
                M2EA = M2EA + 1;
            }
            
            List<Integer> RecordTypeLstforConnection = new Integer[6];
            
            RecordTypeLstforConnection[0] = ConnectionNoType;
            RecordTypeLstforConnection[1] = M2M;
            RecordTypeLstforConnection[2] = M2Prospect;
            RecordTypeLstforConnection[3] = M2Advisor;
            RecordTypeLstforConnection[4] = T2T;
            RecordTypeLstforConnection[5] = M2EA;
            
            ConnectionRecordTypeMap.put(connection.Contact__c,RecordTypeLstforConnection);
            
            ConnectionNoType = 0;
            M2M = 0;
            M2Prospect = 0;
            M2Advisor = 0;
            T2T = 0;
            M2EA = 0;
        }
        system.debug('ConnectionRecordTypeMap count : ' + ConnectionRecordTypeMap.size());
        system.debug('ConnectionRecordTypeMap : ' + ConnectionRecordTypeMap);
        system.debug('ConnectionNoType : ' + ConnectionNoType);
        system.debug('M2M : ' + M2M);
        system.debug('M2Prospect count : ' + M2Prospect);
        system.debug('M2Advisor count : ' + M2Advisor);
        system.debug('T2T count : ' + T2T);
        system.debug('M2EA count : ' + M2EA);
        
        List<Event> evtlst = [Select Id,Type,Subject,WhoId,ActivityDate From Event where Type = 'Meeting' or Type = 'Member Check-In Call' or Type = 'New Member Call' or Type = 'New Member Meeting'];
        
        system.debug(evtlst.size());
        
        //Map<Id,Integer> mapcountevent = new Map<Id,Integer>();
        Map<Id,List<Event>> mapconidwithlstevt = new Map<Id,List<Event>>();
        for(Event e : evtlst)
        {
            if(mapconidwithlstevt.containsKey(e.WhoId))
            {
                List<Event> elst = mapconidwithlstevt.get(e.WhoId);
                elst.add(e);
                mapconidwithlstevt.put(e.WhoId,elst);
            }
            else{
                List<Event> elst = new List<Event>();
                elst.add(e);
                mapconidwithlstevt.put(e.WhoId,elst);
            }
            
        }
        Map<Id,Integer> finalmembercall = new Map<Id,Integer>();
        Map<Id,Date> welcomememberdate  = new Map<Id,Date>();
        for(Id cone : mapconidwithlstevt.keyset())
        {
            List<Event> newevtlst  = mapconidwithlstevt.get(cone);
            
            Integer membercallcount = 0;
            for(Event e2 : newevtlst)
            {
                if(e2.Type == 'Meeting' || e2.Type == 'Member Check-In Call' || e2.Type == 'New Member Call' || e2.Type == 'New Member Meeting')
                {
                    
                    membercallcount = membercallcount + 1;
                }
                if(e2.Type == 'New Member Call')
                {
                    welcomememberdate.put(cone,e2.ActivityDate);
                }
                
            }
            finalmembercall.put(cone,membercallcount);
            membercallcount = 0;
        }
        
        system.debug('mapconidwithlstevt size : ' + mapconidwithlstevt.size());
        system.debug('mapconidwithlstevt : ' + mapconidwithlstevt);
        
        
        
             List<String> str= new List<string>();
    for(String oid: oppstrid.keyset()){
            string oppstr='';
            Opportunity op= oppstrid.get(oid);
            
            //oppstr += '"' + oppstrid.get(oid).Person__c + '","' + oppstrid.get(oid).Id;
           //  oppstr += '"' + oppstrid.get(oid).Person__c + '","' + oppstrid.get(oid).Id + '","' + oppstrid.get(oid).Name + '","' + oppstrid.get(oid).W50_Group__r.Name + '","' + oppstrid.get(oid).Person__r.Salutation + '","' + oppstrid.get(oid).Person__r.FirstName +' '+ oppstrid.get(oid).Person__r.LastName + '","' + oppstrid.get(oid).Renewal_Opp__r.Name + '","' + oppstrid.get(oid).Person__r.Person_Mailing_Region__c + '","' + oppstrid.get(oid).Type + '","' + oppstrid.get(oid).Renewal_Count__c + '","' + oppstrid.get(oid).Term_Start_Date__c + '","' + oppstrid.get(oid).Term_End_Date__c + '","' + oppstrid.get(oid).Term_Actual_Months__c  + '","' + oppstrid.get(oid).Term_Amount__c.format() + '","' + oppstrid.get(oid).Renewal_Opp_Amount__c.format() + '","' + oppstrid.get(oid).Actual_Close_Date__c  + '","' + oppstrid.get(oid).Won_Lost_Reason__c  + '","' + oppstrid.get(oid).Renewal_Opp_Won_Loss_Reason__c  + '","' + oppstrid.get(oid).Renewal_Opp_Stage__c + '","' + oppstrid.get(oid).StageName + '","' ;     
           if(oppstrid.get(oid).Person__c != null || oppstrid.get(oid).Person__c !=''){
                oppstr += '"' + oppstrid.get(oid).Person__c + '","';
            }else           {
            oppstr += '"' + '' + '","';
            }
            if(oppstrid.get(oid).Id != null || oppstrid.get(oid).Id !=''){
                oppstr += oppstrid.get(oid).Id + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Name != null || oppstrid.get(oid).Name !=''){
                oppstr += oppstrid.get(oid).Name + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).W50_Group__r.Name != null || oppstrid.get(oid).W50_Group__r.Name !=''){
                oppstr += oppstrid.get(oid).W50_Group__r.Name + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Person__r.Salutation != null || oppstrid.get(oid).Person__r.Salutation !=''){
                oppstr += oppstrid.get(oid).Person__r.Salutation + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Person__r.FirstName != null || oppstrid.get(oid).Person__r.FirstName !=''){
                oppstr += oppstrid.get(oid).Person__r.FirstName + ' ';
            }else           {
            oppstr +=  ' ';
            }
            if(oppstrid.get(oid).Person__r.LastName != null || oppstrid.get(oid).Person__r.LastName !=''){
                oppstr += oppstrid.get(oid).Person__r.LastName + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Renewal_Opp__r.Name != null || oppstrid.get(oid).Renewal_Opp__r.Name !=''){
                oppstr += oppstrid.get(oid).Renewal_Opp__r.Name + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Person__r.Person_Mailing_Region__c != null || oppstrid.get(oid).Person__r.Person_Mailing_Region__c !=''){
                oppstr += oppstrid.get(oid).Person__r.Person_Mailing_Region__c + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Type != null || oppstrid.get(oid).Type !=''){
                oppstr += oppstrid.get(oid).Type + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Renewal_Count__c != null ){
                oppstr += oppstrid.get(oid).Renewal_Count__c + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Term_Start_Date__c != null ){
                oppstr += oppstrid.get(oid).Term_Start_Date__c + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Term_End_Date__c != null ){
                oppstr += oppstrid.get(oid).Term_End_Date__c + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Term_Actual_Months__c != null ) {
                oppstr += oppstrid.get(oid).Term_Actual_Months__c + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Term_Amount__c != null  ){
                oppstr += oppstrid.get(oid).Term_Amount__c.format() + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Renewal_Opp_Amount__c != null  ){
                oppstr += oppstrid.get(oid).Renewal_Opp_Amount__c.format() + '","';
            }else{
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Actual_Close_Date__c != null){
                oppstr += oppstrid.get(oid).Actual_Close_Date__c + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Won_Lost_Reason__c != null || oppstrid.get(oid).Won_Lost_Reason__c !=''){
                oppstr += oppstrid.get(oid).Won_Lost_Reason__c + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Renewal_Opp_Won_Loss_Reason__c != null || oppstrid.get(oid).Renewal_Opp_Won_Loss_Reason__c !=''){
                oppstr += oppstrid.get(oid).Renewal_Opp_Won_Loss_Reason__c + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).Renewal_Opp_Stage__c != null || oppstrid.get(oid).Renewal_Opp_Stage__c !=''){
                oppstr += oppstrid.get(oid).Renewal_Opp_Stage__c + '","';
            }else           {
            oppstr += '' + '","';
            }
            if(oppstrid.get(oid).StageName != null || oppstrid.get(oid).StageName !=''){
                oppstr += oppstrid.get(oid).StageName + '","';
            }else           {
            oppstr += '' + '","';
            }
            

            if(CampaignRecordTypeMap.size()>0){
         if(CampaignRecordTypeMap.containsKey(oid))
            {
                
                oppstr += string.valueof(CampaignRecordTypeMap.get(oid).get(0)) + '","' + string.valueof(CampaignRecordTypeMap.get(oid).get(1)) + '","' + 
                    string.valueof(CampaignRecordTypeMap.get(oid).get(2)) + '","' + string.valueof(CampaignRecordTypeMap.get(oid).get(3)) + '","' + 
                    string.valueof(CampaignRecordTypeMap.get(oid).get(4)) + '","' + string.valueof(CampaignRecordTypeMap.get(oid).get(5)) + '","';
                
            }
            else
            {
                oppstr += '0","0","0","0","0","0","';
            }
            }
            else{
                  oppstr += '0","0","0","0","0","0","';
            }
            if(ConnectionRecordTypeMap.size()>0){
          if(ConnectionRecordTypeMap.containsKey(op.Person__c))
            {
                string cid =op.Person__c;
                oppstr += string.valueof(ConnectionRecordTypeMap.get(cid).get(0)) + '","' + string.valueof(ConnectionRecordTypeMap.get(cid).get(1)) + '","' + string.valueof(ConnectionRecordTypeMap.get(cid).get(2)) + '","' + string.valueof(ConnectionRecordTypeMap.get(cid).get(3)) + '","' + string.valueof(ConnectionRecordTypeMap.get(cid).get(4)) + '","' + string.valueof(ConnectionRecordTypeMap.get(cid).get(5)) + '","';
            }
            else
            {
                oppstr +=  '0","0","0","0","0","0","';
            }}
            else{
              oppstr +=  '0","0","0","0","0","0","';
            }
            if(welcomememberdate.size()>0){
         if(welcomememberdate.containsKey(op.Person__c ))
            {
                string cid = op.Person__c;
                oppstr += welcomememberdate.get(cid) +'","';
            }
            else
            {
                oppstr +=  '0","';
            }}
            else{
                oppstr +=  '0","';
            }
                if(finalmembercall.size()>0){
            if(finalmembercall.containsKey(op.Person__c ))
            {
                string cid = op.Person__c;
                oppstr += finalmembercall.get(cid) +'","';
            }
            else
            {
                oppstr +=  '0","';
                }}
                else{
                  oppstr +=  '0","';
                }
            
            if(OnedegreeMap.size()>0){
            if(OnedegreeMap.containsKey(op.Person__c))
            {
                string cid = op.Person__c;
                oppstr += OnedegreeMap.get(cid).get(0) + '","' + OnedegreeMap.get(cid).get(1) +'"';
            }
            else
            {
                oppstr +=  '-","-"';
            }
            }else{
                   oppstr +=  '-","-"';
            }
            csvfile = csvfile + oppstr + '\r\n';
        system.debug(oppstr);   
        }
        
        
        
    
    }    
    global void finish(Database.BatchableContext bc){
        String data = 'Person Case Safe Id, Opp Case Safe Id, Opportunity Name ,W50 Group, Salutation, Person, Renewal Opp, Person : Mailing Region, Type, Renewal Count, Term Start Date, Term End Date, Actual Month,Amount,Renewal Amount, Actual Close Date,Won / Lost Reason ,Renewal Won-Lost Reason,Renewal Opp Stage, StageName ,Engage Calls, One Degree, Round Table, Summits, W50 Program, W50 Special Program, Connection-No Type, M2M, M2Prospect, M2Advisor, T2T, M2EA, Check In Call, Total Call,One Degree Initiated, One Degree Response';
       // String data = 'Person Case Safe Id, Opp Case Safe Id, Opportunity Name ,W50 Group, Salutation, Person, Renewal Opp, Person : Mailing Region, Status, Renewal Count, Term Start Date, Term End Date, Actual Term, Renewal Amount, Actual Close Date, Engage Calls, One Degree, Round Table, Summits, W50 Program, W50 Special Program, Connection-No Type, M2M, M2Prospect, M2Advisor, T2T, M2EA, Check In Call, One Degree Initiated, One Degree Response'; 
        Opportunity_Report__c report = new Opportunity_Report__c();
        report.Name = 'Opportunity Report' + datetime.now();
        insert report ;
        Attachment attachment = new Attachment();
        String finalCSV = data+ '\r\n'+csvfile;
attachment.Body = Blob.valueOf(finalCSV);
attachment.Name = 'csvFile.csv';
attachment.ParentId =report.id;
insert attachment;
        
    }
}