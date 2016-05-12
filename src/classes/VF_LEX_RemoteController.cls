global class VF_LEX_RemoteController {
    
    public Map<String,Schema.SObjectType> ObjectMap;
    
    public VF_LEX_RemoteController(){
        ObjectMap = new Map<String,Schema.SObjectType>();
        ObjectMap = Schema.getGlobalDescribe();
    }
    public static List<Account> account { get; set; }
    
    public void myActionInController(){
        System.debug('WOW');
        string objectName = Apexpages.currentPage().getParameters().get('firstParam');
        string buttonType = Apexpages.currentPage().getParameters().get('secondParam');
        string mobilePhoneField = Apexpages.currentPage().getParameters().get('thirdParam');
        string javascriptCode = '';
        if(buttonType == 'Single'){
            javascriptCode = SingleSMSEvent(objectName,mobilePhoneField);
            //CustomMetadataServices.readAndUpdateLayout(objectName,SingleSMSEvent(),buttonType,buttonType);
        }
        else if(buttonType == 'Single Popup'){
            javascriptCode = SinglePopupSMSEvent(objectName,mobilePhoneField);
        }
        else if(buttonType == 'Bulk'){
            javascriptCode = BulkSMSEvent(objectName,mobilePhoneField);
        }
        else if(buttonType == 'Bulk Popup'){
            javascriptCode = BulkPopupSMSEvent(objectName,mobilePhoneField);
        }
        CustomMetadataServices.createWebLink(objectName,javascriptCode,buttonType,buttonType);
    }
    @RemoteAction
    global static List<String> getObjects() {
        List<String> objectList = new List<String>();
        List<String> sortObject = new List<String>();
        sortObject.addAll(Schema.getGlobalDescribe().KeySet());
        Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(sortObject);
        objectList.add('Select');
        for(Schema.DescribeSObjectResult res : results)
        {
            String resString = res.getName();
            if(!res.isCustomSetting() && !resString.containsignorecase('history') && !resString.containsignorecase('tag')&&
               !resString.containsignorecase('share') && !resString.containsignorecase('feed') && res.isAccessible() && res.isUpdateable())
            {	
            	//objectList.add(res.getName(),res.getLabel());
            	objectList.add(res.getName());
            }
        }
        return objectList;
    }
    @RemoteAction
    global static List<String> getMobilePhoneField(string objectName){
     	List<String> phoneList = new List<String>();
      	Schema.SObjectType IndividualObject =  Schema.getGlobalDescribe().get(objectName);
      	Map<String, Schema.SObjectField> fieldMap = IndividualObject .getDescribe().fields.getMap();
       	if(objectName != '0')
       	{
        	for(String fieldName : fieldMap.keySet())
        	{
	            schema.describefieldresult dfield = fieldMap.get(fieldName).getDescribe();
	            Schema.DisplayType fdataType = fieldMap.get(fieldName).getDescribe().getType();
	            if(fdataType == Schema.DisplayType.TEXTAREA ||fdataType == Schema.DisplayType.PHONE)
	            {
    	             phoneList.add(String.valueOf(fieldName));
        	    }
        	}
       	} 
     	return phoneList;
    }
    //Description - Generates javascript code for Single SMS by appeding the values selected by user on VF Page
	//CODE By - Mustafa 
	//Date - 4th May 2016
    private string SingleSMSEvent(string objectName,string mobilePhoneField){
    	return '//SINGLE SMS \n{!REQUIRESCRIPT("/soap/ajax/14.0/connection.js")} \n' +
		'{!REQUIRESCRIPT("/soap/ajax/14.0/apex.js")} \n' +
		'{!REQUIRESCRIPT("/resource/smagicinteract__smJQuery/js/jquery-1.10.2.js")}\n'+
		'{!REQUIRESCRIPT("/resource/smagicinteract__smJQuery/js/jquery-ui-1.10.4.custom.min.js")}\n'+
		'{!REQUIRESCRIPT("/resource/smagicinteract__sendSMSJS")}\n' +
		'var packagePrefix = "smagicinteract__";\n'+
		'var recordType = "'+objectName+'";\n'+
		'var idToUpdate = "";\n'+ 
		'var nameField = "@NAMEFIELD";\n'+
		'var mobileField = "'+mobilePhoneField+'";\n'+
		'var optOutField = "smagicinteract__@choosenOptOutField";\n'+
		'var optOutDefaultValue = "@choosenopField";\n'+
		'var smsType = ""; \n'+
		'var userId = "{!$User.Id}"; \n'+
		'var elementIdVar = ""; \n'+
		'var showUserDropDown = false; \n'+
		'var dialogTitle = ""; \n'+
		'var cssUrl = "{!URLFOR("/resource/smagicinteract__smJQuery/css/sm-theme/jquery-ui-1.10.4.custom.min.css")}";\n'+
		'var relatedObjects = "<Related_Object_1>,<Related_Object_2>"; \n'+
		'openSMSPage(recordType, idToUpdate, userId, nameField, mobileField, optOutField, optOutDefaultValue, smsType, elementIdVar, packagePrefix, showUserDropDown, dialogTitle, cssUrl, relatedObjects);';    
    }
    //Description - Generates javascript code for Single POP UP SMS by appeding the values selected by user on VF Page
	//CODE By - Mustafa 
	//Date - 4th May 2016
    private string SinglePopupSMSEvent(string objectName,string mobilePhoneField){
        return '//SINGLE POP UP \n{!REQUIRESCRIPT("/soap/ajax/14.0/connection.js")}\n'+
		'{!REQUIRESCRIPT("/soap/ajax/14.0/apex.js")}\n'+
		'{!REQUIRESCRIPT("/resource/smagicinteract__smJQuery/js/jquery-1.10.2.js")}\n'+
		'{!REQUIRESCRIPT("/resource/smagicinteract__smJQuery/js/jquery-ui-1.10.4.custom.min.js")}\n'+
		'{!REQUIRESCRIPT("/resource/smagicinteract__sendSMSJS")}\n'+
		'var packagePrefix = "smagicinteract__";\n'+
		'var recordType = "'+objectName+'";\n'+
		'var idToUpdate = "";\n'+
		'var nameField = "@NAMEFIELD";\n'+ 
		'var mobileField = "'+mobilePhoneField+'";\n'+
		'var optOutField = "smagicinteract__@choosenOptOutField";\n'+
		'var optOutDefaultValue = @choosenopField";\n'+
		'var smsType = "popup";\n'+
		'var userId = "{!$User.Id}";\n'+
		'var elementIdVar = "";\n'+
		'var showUserDropDown = false;\n'+
		'var dialogTitle = "";\n'+
		'var cssUrl = "{!URLFOR("/resource/smagicinteract__smJQuery/css/sm-theme/jquery-ui-1.10.4.custom.min.css")}";\n'+
		'var relatedObjects = "<Related_Object_1>,<Related_Object_2>";\n'+
		'openSMSPage(recordType, idToUpdate, userId, nameField, mobileField, optOutField, optOutDefaultValue, smsType, elementIdVar, packagePrefix, showUserDropDown, dialogTitle, cssUrl, relatedObjects);';
    }
    //Description - Generates javascript code for BULK SMS by appeding the values selected by user on VF Page
	//CODE By - Mustafa 
	//Date - 4th May 2016
    private string BulkSMSEvent(string objectName,string mobilePhoneField){
        return '//BULK SMS \n {!REQUIRESCRIPT("/soap/ajax/10.0/connection.js")}\n'+
		'{!REQUIRESCRIPT("/soap/ajax/14.0/apex.js")}\n'+
		'function loadJqueryDynamically(){\n'+
		'var newscript = document.createElement("script");\n'+
		'newscript.type = "text/javascript";\n'+
		'newscript.async = false;\n'+
		'newscript.src = "{!URLFOR("/resource/smagicinteract__smJQuery/js/jquery-1.10.2.js")}";\n'+
		'(document.getElementsByTagName("head")[0]||document.getElementsByTagName("body")[0]).appendChild(newscript);\n'+
		'var newscript1 = document.createElement("script");\n'+
		'newscript1.type = "text/javascript";\n'+
		'newscript1.async = false;\n'+
		'newscript1.src = "{!URLFOR("/resource/smagicinteract__smJQuery/js/jquery-ui-1.10.4.custom.min.js")}";\n'+
		'(document.getElementsByTagName("head")[0]||document.getElementsByTagName("body")[0]).appendChild(newscript1);\n'+
		'var newscript2 = document.createElement("script");\n'+
		'newscript2.type = "text/javascript";\n'+
		'newscript2.async = false;\n'+
		'newscript2.src = "{!URLFOR("/resource/smagicinteract__sendSMSJS")}";\n'+
		'(document.getElementsByTagName("head")[0]||document.getElementsByTagName("body")[0]).appendChild(newscript2);\n'+
		'newscript2.onload = showPage;\n'+
		'}\n'+
		'loadJqueryDynamically();\n'+
		'function showPage() {\n'+
		'var records = {!GETRECORDIDS($ObjectType.'+objectName+')};\n'+
		'if (records[0] == null)\n'+
		'{\n'+
		'alert("Please select at least one lead")\n'+
		'}\n'+
		'else{\n'+
		'var packagePrefix = "smagicinteract__";\n'+
		'var recordType = "'+objectName+'";\n'+
		'var recordIds = "";\n'+
		'var nameField = "@NAMEFIELD";\n'+
		'var mobileField = "'+mobilePhoneField+'";\n'+
		'var optOutField = "smagicinteract__@choosenOptOutField";\n'+
		'var optOutDefaultValue = @choosenopField";\n'+
		'var smsType = "";\n'+
		'var userId = ”{!$User.Id}”;\n'+
		'var elementIdVar = "";\n'+
		'var showUserDropDown = false;\n'+
		'var dialogTitle = "";\n'+
		'var queryString = "";\n'+
		'var relatedObjects = "@RELATEDOBJECT1,@RELATEDOBJECT2";\n'+
		'for (var n in records) {\n'+
		'if(n == "remove" || n == "indexOf") continue;\n'+
		'recordIds = recordIds + records[n];\n'+
		'if (n != records.length-1) {\n'+
		'recordIds = recordIds + ",";\n'+
		'}\n'+
		'}\n'+
		'var cssUrl = "{!URLFOR("/resource/smagicinteract__smJQuery/css/sm-theme/jquery-ui-1.10.4.custom.min.css")}";\n'+
		'if(Permission.smagicinteract__AllowToSendBulkMessage) { \n'+
		'openSMSPage(recordType, recordIds, userId, nameField, mobileField, optOutField, optOutDefaultValue, smsType, elementIdVar, packagePrefix, showUserDropDown, dialogTitle, cssUrl, relatedObjects);\n'+
		'}\n'+
		'else { \n'+
		'alert("You cannot Send SMS. Please contact system admin"); \n'+
		'} \n'+
		'}\n'+
		'}';
    }
    //Description - Generates javascript code for BULK POP UP SMS by appeding the values selected by user on VF Page
	//CODE By - Mustafa 
	//Date - 4th May 2016
    private string BulkPopupSMSEvent(string objectName,string mobilePhoneField){
        return '//BULK SMS POPUP \n{!REQUIRESCRIPT("/soap/ajax/10.0/connection.js")}\n'+
		'{!REQUIRESCRIPT("/soap/ajax/14.0/apex.js")}\n'+
		'function loadJqueryDynamically(){\n'+
		'var newscript = document.createElement("script");\n'+
		'newscript.type = "text/javascript";\n'+
		'newscript.async = false;\n'+
		'newscript.src = "{!URLFOR("/resource/smagicinteract__smJQuery/js/jquery-1.10.2.js")}";\n'+
		'(document.getElementsByTagName("head")[0]||document.getElementsByTagName("body")[0]).appendChild(newscript);\n'+
		'var newscript1 = document.createElement("script");\n'+
		'newscript1.type = "text/javascript";\n'+
		'newscript1.async = false;\n'+
		'newscript1.src = "{!URLFOR("/resource/smagicinteract__smJQuery/js/jquery-ui-1.10.4.custom.min.js")}";\n'+
		'(document.getElementsByTagName("head")[0]||document.getElementsByTagName("body")[0]).appendChild(newscript1);\n'+
		'var newscript2 = document.createElement("script");\n'+
		'newscript2.type = "text/javascript";\n'+
		'newscript2.async = false;\n'+
		'newscript2.src = "{!URLFOR("/resource/smagicinteract__sendSMSJS")}";\n'+
		'(document.getElementsByTagName("head")[0]||document.getElementsByTagName("body")[0]).appendChild(newscript2);\n'+
		'newscript2.onload = showPage;\n'+
		'}\n'+
		'loadJqueryDynamically();\n'+
		'function showPage() {\n'+
		'var records = {!GETRECORDIDS($ObjectType.'+objectName+')};\n'+
		'if (records[0] == null)\n'+
		'{\n'+
		'alert("Please select at least one lead");\n'+
		'}\n'+
		'else{\n'+
		'var packagePrefix = "smagicinteract__";\n'+
		'var recordType = "'+objectName+'";\n'+
		'var recordIds = "";\n'+
		'var nameField = "@NAMEFIELD";\n'+
		'var mobileField = "'+mobilePhoneField+'";\n'+
		'var optOutField = "@choosenOptOutField";\n'+
		'var optOutDefaultValue = "@choosenopField";\n'+
		'var smsType = "popup";\n'+
		'var userId = "{!$User.Id}";\n'+
		'var elementIdVar = "";\n'+
		'var showUserDropDown = false;\n'+
		'var dialogTitle = "";\n'+
		'var queryString = "";\n'+
		'var relatedObjects = "@RELATEDOBJECT1,@RELATEDOBJECT2";\n'+
		'for (var n in records) {\n'+
		'if(n == "remove" || n == "indexOf") continue;\n'+
		'recordIds = recordIds + records[n];\n'+
		'if (n != records.length-1) {\n'+
		'recordIds = recordIds + ",";\n'+
		'}\n'+
		'}\n'+
		'var cssUrl = "{!URLFOR("/resource/smagicinteract__smJQuery/css/sm-theme/jquery-ui-1.10.4.custom.min.css")}";\n'+
		'if(Permission.smagicinteract__AllowToSendBulkMessage) { \n'+
		'openSMSPage(recordType, recordIds, userId, nameField, mobileField, optOutField, optOutDefaultValue, smsType, elementIdVar, packagePrefix, showUserDropDown, dialogTitle, cssUrl, relatedObjects);\n'+
		'}\n'+
		'else { \n'+
		'alert("You cannot Send SMS. Please contact system admin"); \n'+
		'} \n'+
		'}\n'+
		'}';
    }
}