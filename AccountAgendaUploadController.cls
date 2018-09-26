/**
 * Controller for the CampaignAgendaUpload VF page.  Allows saving a Campaign attachment
 * and linking the Campaign to the document.
 *
 * @author tschulte@highondemand.com
 * @date July 17, 2014
 */
public class AccountAgendaUploadController {

    private Id AccountId;
    public Blob body {get;set;}
    public String docName {get; set;}
    public Boolean isSaved {get;set;}


    public AccountAgendaUploadController (ApexPages.StandardController controller) {

        AccountId = controller.getId();
        isSaved = false;
    }

    public PageReference save() {

        if (docName == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please select a document.'));
            return null;
        }

        System.Savepoint sp = Database.setSavepoint();

        try {
            Attachment attachment = new Attachment();
            attachment.Body = body;
            attachment.Name = fitToNameField(docName);
            attachment.ParentId = AccountId;
            insert attachment;

            //Account acc = new Account(Id = AccountId);
            //acc.Agenda_File_ID__c = attachment.Id;
            //acc.Agenda_Filename__c = attachment.Name;
            //update acc;
            
                        isSaved = true;

        } catch (Exception ex) {
            Database.rollback(sp);
            throw ex;
        }
        pagereference pr = new pagereference('/' + AccountId);
       
        return pr;
    }

    private static String fitToNameField(String name) {

        Integer length = name.length();

        if(length > 255) {
            return name.substring(0, 255);
        }

        return name;
    }
}