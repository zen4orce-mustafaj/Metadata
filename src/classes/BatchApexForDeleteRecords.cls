global class BatchApexForDeleteRecords implements Database.Batchable<sObject>,Database.Stateful 
{
    global list<String> lstOfObj = new list<String>();
    global String query ;
    SelectorHandlerClassForDataCleanUp selector = new SelectorHandlerClassForDataCleanUp();
    DomainHandlerClassForDataCleanUp d = new DomainHandlerClassForDataCleanUp();
    
    //Constructor of the class
    global BatchApexForDeleteRecords(String str,list<String> strList)
    {
        try
         {
            query = 'SELECT Id FROM '+ str;
        	lstOfObj = strList ; 
         }
        catch(Exception ex)
         {
            System.debug('ERROR:'+ex.getMessage());
         }
    } 
    
    //Start method of batch class
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
       try
        {
           return selector.queryLocatorById(query); //pass dynamic query to get the list of records
        }
       catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
            return null;
        }
	}
    
    //Execute method of batch class
	global void execute(Database.BatchableContext BC,list<SObject> objRecordList)
    {
       try
        {
            d.executeMethod(objRecordList);
        }
       catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
    }
    
    //finish method of the batch class
   global void finish(Database.BatchableContext ctx) 
   {
       try
       {
           lstOfObj.remove(0);
           System.debug('in finish method'+ lstOfObj[0]);
           if(lstOfObj.size() > 0)//Call batch class again for delete another object's record
           {
               Id batchInstanceId = Database.executeBatch(new BatchApexForDeleteRecords(lstOfObj.get(0),lstOfObj),2000);   
           }
           else
           {
               Id idOfCurrentBetch = ctx.getJobId();
               AsyncApexJob a = selector.asyncApexJobDetails(idOfCurrentBetch);
               // Send an email to the Apex job's submitter notifying of job completion.
               Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
               String[] toAddresses = new String[] {a.CreatedBy.Email};
               mail.setToAddresses(toAddresses);
               mail.setSubject('Apex Sharing Recalculation ' + a.Status);
			   mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +a.Status+
					' batches with '+ a.NumberOfErrors + ' failures.');
			   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
			}
       }
       catch(Exception ex)
       {
           System.debug('ERROR:'+ex.getMessage());
       }
   }
}