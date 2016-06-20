public class DeleteRecords {

    Map<String,integer> cusObj{get;set;}
    Map<String,integer> stdObj{get;set;}
    list<String> ObjList{get;set;}
    ChildParentRelationshipList ex = new ChildParentRelationshipList();
    
    //Constructor of the class
    public DeleteRecords()
    {
        try
        {
            cusObj 	= new Map<String,integer>();
            stdObj 	= new Map<String,integer>(); 
            ObjList	= new list<String>();
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
    }
    //Get the list of all CustomObjects
    public  Map<String,integer> getCusObj()
    {
        try
        {
            cusObj = ex.AllCustomObj();  
            return cusObj;
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
            return null;
        }
    }
    //Get the list of all StandardObjects
    public Map<String,integer> getStdObj()
    {
        try
        {
            stdObj = ex.AllStandardObj();
        	return stdObj;
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
            return null;
        }
    }
    //Delete All Records of Standard Objects by calling batch class 
    public void deleteStandardRecordButton(Map<String,integer> mapToListRecords)
    {
        try
        {
            list <String> stdObjList = new list<String>();
            stdObjList =  ex.convertMapToList(stdObj);
            for(String s : stdObjList)
            {
                System.debug('Standard Objects' + s);
            }
            if(stdObjList.size() > 0)
            {
                ex.findChildObjects(stdObjList);
                list<String> strList = new list<String>();
                strList =  ex.findNullValues();
               // BatchApexForDeleteRecords d = new BatchApexForDeleteRecords(strList.get(0),strList);//created an instance to call Batch Apex class 
                //database.executeBatch(d);
            }
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
    }
    //Delete All Records of Custom Objects by calling batch class 
    public void deleteCustomRecordButton(Map<String,integer> mapToListRecords)
    {
        try
        {
            list <String> cusObjList = new list<String>();
            cusObjList =  ex.convertMapToList(cusObj);
            if(cusObjList.size() > 0)
            {
                ex.findChildObjects(cusObjList);
                list<String> strList = new list<String>();
                strList =  ex.findNullValues();
                for(String s1 : strList)
                {
                	System.debug('final List' + s1);
            	}
                for(String s : cusObjList)
                {
                	System.debug('Custom Objects' + s);
            	}
                //BatchApexForDeleteRecords d = new BatchApexForDeleteRecords(strList.get(0),strList);//created an instance to call Batch Apex class 
                //database.executeBatch(d,2000);
            }
        } 
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
    }
}