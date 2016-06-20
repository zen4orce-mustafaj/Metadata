public class DomainHandlerClassForDataCleanUp {
    
    //Delete a list of records 
    public void executeMethod(list<SObject> lstOfRecords)
    {
        try
        {
            if(lstOfRecords.size() > 0)
            {
                delete lstOfRecords;
            }
        }
       catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
    }

}