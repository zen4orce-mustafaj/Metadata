public  with sharing class SalesforceBannerController  {
    public string objects {get;set;}
    public list<selectOption>  objectsList ;
    public Map<String,Schema.SObjectType> objectMap;
    public string buttonType{get;set;}
    public list<string> mobilePhone{get;set;}
    public Schema.SObjectType sobjtype;
    public string optOutField {get;set;}
    public string defaultOptoutField {get;set;}	
    public list<selectOption> mPhonelist {get;set;}
    public list<selectOption> smsOptOutList {get;set;}
    public string buttonLabel{get;set;}
    
    //Constructor of the class
    public SalesforceBannerController()
    {       
        try
        {
            // Try-catch block for handling exceptions
	        objects = 'NONE';
	        objectslist = new list<selectoption>();
            MobilePhone = new list<String>();
	        defaultOptoutField = 'Yes';
        }
        catch(Exception e)
        {
        	//you can display this message on screen to notify user in apex:messages
        	 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
    }

    // Get the Populated fields of Mobile Phone list and OptOutlist  Values in one method
    /* Description - Purpose of this method is to populate the related fields like mobile phone, text, formula field on VF page 
    depending on the selected object */
    
    public void populateFields()
    {
        try{
            // Try-catch block for handling exception   
            	mPhonelist = new list<SelectOption>();
                smsOptOutList = new list<SelectOption>();
                if(Objects != 'NONE')
                {
                    mPhonelist = getMphonelist();//get the list of all mobile phone fields for selected object
                    smsOptOutList = getOptOutFieldList();// get the list of all boolean and formula boolean fields for selected objects
                }
                  
        }
        catch(Exception e)
        {
        	 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
     }
    
    //Fetch the list of Object in the method
    /* Description - Purpose of this constructor is to fetch the list of custom and standard object 
    with specific features and setting the deafuilt values on VF page */
    
   public list<selectoption> getListOfObjects()
   {
      objectslist.add(new selectOption('NONE','NONE'));
      objectMap = Schema.getGlobalDescribe();
      list<String> sortObject = new list<String>();
      sortObject.addAll(ObjectMap.KeySet());
      DescribeSObjectResult[] results = Schema.describeSObjects(sortObject); 
      for(Schema.DescribeSObjectResult res : results)
      	{
            if(!res.isCustomSetting() && res.getRecordTypeInfos().size() > 0  && res.isSearchable() && res.isDeletable() && res.isCreateable() && res.isUpdateable()  && res.isUndeletable() )
            {
                objectsList.add(new selectOption(res.getName(),res.getLabel()));
            }
        }
      objectsList.sort();
      return objectsList;
   }
    
   //Get the list of SMS Button Type
   /*Description - Purpose of this method is to fetch the list of button type using custom setting ButtonType__c*/
    
   public list<selectOption> getBTypeList()
   {
        list<selectOption> bType = new list<selectOption>();
        try
        {
           for(ButtonType__c b : ButtonType__c.getall().values())
            {
                 bType.add(new selectOption(b.name,b.name));
            }
        }
        catch (Exception e)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        } 
        return bType;
   }
    //Get the list of DefaultOptoutField
    /*Description purpose of this method is to fetch the list of DefaultOptoutField using custom setting DefaultOptOut__c*/
   public list<selectOption> getdOptoutFieldList()
   {
    	list<selectOption> opField = new list<selectOption>();
    	try
    	{
	    	for(DefaultOptOut__c d : DefaultOptOut__c.getAll().values()) 
            {
                opField.add(new selectOption(d.name,d.name));
            }
	    }
    	catch(Exception e)
    	{
    		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
    	}  
        return opField;
    }
    
    //Fetch the list of Mobile list 
    /* Description - Purpose of this Method is to fetch the list of custom and standard object 
    with specific features and setting the deafuilt values on VF page */
    
	public list<selectOption> getMphonelist()
  	{
        list<selectOption> mPhoneList = new list<selectOption>();
        try
        {
            sobjtype = objectMap.get(Objects) ;
            Map<String, Schema.SObjectField> fieldMap = sobjtype.getDescribe().fields.getMap();
            for(String fieldName : fieldMap.keySet())
            {
                //Provides the datatype of field
                Schema.DisplayType fDataType = fieldMap.get(fieldName).getDescribe().getType();
                if(fDataType == Schema.DisplayType.STRING ||fDataType == Schema.DisplayType.PHONE)
                {
                    mPhoneList.add(new selectOption(String.valueOf(fieldName),String.valueOf(fieldName)));
                    
                }
                
            }
        } 
		catch(Exception e)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
      	return mPhoneList;
  }
    //Fetch the list of SMS Optout Fields proper description required
    /*Description - Purpose of this method is to get the related fields like Boolean fields and  formula fields on VF page 
      depending on the selected object*/
  public list<selectOption> getOptOutFieldList()
  {
	list<selectOption> outField = new list<selectOption>();
   	try
    {
        sObjType = objectMap.get(objects);      
        Map<String, Schema.SObjectField> fieldMap = sObjType.getDescribe().fields.getMap();
        for(String fieldName : fieldMap.keySet())
            {
                //It provide to get the object field data type.
                Schema.DisplayType fDataType = fieldMap.get(fieldName).getDescribe().getType();
                schema.describefieldresult dField = fieldMap.get(fieldName).getDescribe();
                if(fDataType == Schema.DisplayType.BOOLEAN)
                {
                    OutField.add(new selectOption(String.valueOf(fieldName),String.valueOf(fieldName)));
                }
            } 
    }
    catch(Exception e)
    {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
    }
    return outField;
   } 
   //Method for creating a Button 
    public void createButton()
    {
        try
        {
           if(buttonType == 'Single')
            {
                MetadataServiceExamples.createButton(objects,sendSMSButton(), buttonLabel);
            }
        }
        catch(Exception e)
        {
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Button Label is already present.Please enter different button label '));
        }
    }   
    //Get the JavaScript code as a  string to create a button 
    public String sendSMSButton()
    {
        // CS
       String s1 = 
            '{!REQUIRESCRIPT("/soap/ajax/14.0/connection.js")} '+
            '{!REQUIRESCRIPT("/soap/ajax/14.0/apex.js")} '+
            '{!REQUIRESCRIPT("/resource/smagicinteract__smJQuery/js/jquery-1.10.2.js")}'+ 
            '{!REQUIRESCRIPT("/resource/smagicinteract__smJQuery/js/jquery-ui-1.10.4.custom.min.js")} '+
            '{!REQUIRESCRIPT("/resource/smagicinteract__sendSMSJS")}'+
            'var packagePrefix = "smagicinteract__";'+ 
            'var recordType = "lead";'+
            'var idToUpdate = "{!Lead.Id}";'+ 
            'var nameField = "Name";'+ 
            'var mobileField = "choosenMobilePhone"; '+
            'var optOutField = "choosenOptOutField";'+
            'var optOutDefaultValue = "choosenopField";'+
            'var smsType = " "; '+
            'var userId = "{!$User.Id}";'+ 
            'var elementIdVar = " " ;'+ 
            'var showUserDropDown = false; '+
            'var dialogTitle = " "; '+
            'var cssUrl = "{!URLFOR("/resource/smagicinteract__smJQuery/css/sm-theme/jquery-ui-1.10.4.custom.min.css")}";'+
            'var relatedObjects = ‘<Related_Object_1>,<Related_Object_02>’; '+
            'openSMSPage(recordType, idToUpdate, userId, nameField, mobileField, optOutField, optOutDefaultValue, smsType, elementIdVar, packagePrefix, showUserDropDown, dialogTitle, cssUrl, relatedObjects);';
		 return s1;
    }
}