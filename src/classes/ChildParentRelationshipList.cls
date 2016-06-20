public class ChildParentRelationshipList {
    public 	Map<String,Schema.SObjectType> lstOfObj{get;set;} 
    public  list<String> objects{get;set;}
    public  list<String> finalRelationList{get;set;}
    public  Map<String , Set<String>> mapObj_Rel{get;set;} 
    SelectorHandlerClassForDataCleanUp selector = new SelectorHandlerClassForDataCleanUp();
    
    //Constructor of the class
    public 	ChildParentRelationshipList()
    {
        try
        {
            lstOfObj = Schema.getGlobalDescribe();//get all the objects from org using getGlobalDescribe()
            finalRelationList = new list<String>();
            objects = new list<String>();
            objects.addAll(lstOfObj.KeySet());
            mapObj_Rel= new  Map<String , Set<String>>(); 
        }
       catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
    }
    
    //Get a list of All Standard Objects
    public Map<String,integer> AllStandardObj()
    {
        try
        {
            Map<String,integer> objectList = new Map<String,integer>();
            for(integer i =0;i< objects.size();i++)
            {
                if(objects[i].endsWith('kav') || objects[i].containsIgnoreCase('CollaborationGroupRecord'))
                {
                   if(objects[i].endsWith('kav'))
                   {
                      String value = objects[i];
                      value.replace(value, 'KnowledgeArticleVersion');
                   }
                   else
                   {
                    objects.remove(i);
                   }
                }
            }
            Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(objects);
            for(Schema.DescribeSObjectResult res : results)
            {
                String resString = String.valueOf(res.getName());
                if(!res.isCustomSetting()  && !res.iscustom() && res.getRecordTypeInfos().size() > 0 && res.isqueryable()  && res.isDeletable() && res.isCreateable())//get the list of objetcs which are queryable,deletable and creatable
                {
                    integer count = selector.numberOfReocrds(resString) ;
                    objectList.put(res.getname(),count);
                }
             } 
            return objectList;
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
            return null;
        }
     }
    
    //Get a list of All Custom Objects
    public Map<String,integer> AllCustomObj()
    {
        try
        {
            Map<String,integer> objectList = new Map<String,integer>();
            Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(objects);
            String nameSpace = selector.nameSpaceprefixOfOrg();
            System.debug('');
            System.debug('namespace'+nameSpace);
            for(Schema.DescribeSObjectResult res : results)
            {
                String resString = String.valueOf(res.getName());
                if(!res.isCustomSetting()  && res.iscustom() && res.getRecordTypeInfos().size() > 0 && res.isqueryable()  && res.isDeletable() && res.isCreateable())//get the list of objetcs which are queryable,deletable and creatable
                    {
                        if(nameSpace != null && resString.startsWith(nameSpace + '__'))
                		{
                            integer count = selector.numberOfReocrds(resString) ;
                            objectList.put(res.getname(),count);
                        }
                        else if(namespace == null && resString.countMatches('__') < 2)
                        {
                            integer count = selector.numberOfReocrds(resString) ;
                            objectList.put(res.getname(),count);
                        } 
                    }
                }
                 return objectList; 
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
            return null;
        }
    }
    
    //Convert a Map to List using this method
    public list<String> convertMapToList(Map<String,Integer> objList)
    {
        try
        {
            list<String> listOfString = new list<String>();
            if(objList.size() > 0)
            {
                for(String s : objList.keySet())
                {
                   if(objList.get(s) != 0)
                    {
                        listOfString.add(s);
                    }
                }
                
            }
            return listOfString;
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
            return null;
        }
    }
    /* This method finds the relation between parent and child and store it in mapObj_Rel*/
    public void findChildObjects(list<String> objList)
    {
        try
        {
           
            for(String objName : objList)
            {
                Schema.SObjectType sobjType = lstOfObj.get(objName);
                Schema.DescribeSObjectResult R = sobjType.getDescribe();
                if(R.isqueryable() && R.isDeletable() )
                {
                    Set<String> putInMap = new Set<String>();
                    list<Schema.ChildRelationship> childRel = R.getChildRelationships();
                    if(childRel != null)
                    {
                        for(Schema.ChildRelationship cr : childRel)
                        {
                            if(cr.isRestrictedDelete() &&  String.valueOf(cr.getChildSObject()) != objName )
                            {
                                list<String> recussionList = new list<String>();
                                recussionList.add(String.valueOf(cr.getChildSObject()));
                                findChildObjects(recussionList);
                                putInMap.add(String.valueOf(cr.getChildSObject()));
                            }
                        }
                    }
                   mapObj_Rel.put(objName,putInMap) ;//It creates a map relation which stores parent as a key and its related objects as child
                }
            }
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
    }
    /* Call Recurssion function to find child's child*/
    public list<String> findNullValues()
    {
        try
        {
            for(String k : mapObj_Rel.keySet())
            {
                checkForRelationShip(k);
                finalRelationList.add(k);
            }
            return finalRelationList;
    	}
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
            return null;
        }
    }
    /* This method is used to find child who is not parent of another object*/
    public void checkForRelationShip(String keys)
    {
        try
        {
            Set<String> mapValues = new Set<String>();
            mapValues = mapObj_Rel.get(keys);
            if(mapValues != null)
            {
                for(String values : mapValues)
                {
                    checkForRelationShip(values);
                }
            }
    	}
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
	}
    
    
}