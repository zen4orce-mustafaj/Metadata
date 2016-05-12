public class SalesConfigHandler{
	//Update Appointment confirmation in custom setting
    @AuraEnabled
    public static void updateSendapnmt(boolean sendApmt)
    {
        sales__c con=[select id, AppointmentConfirmation__c from sales__c Limit 1];
		if(sendApmt==true)
           	con.AppointmentConfirmation__c=true;
        else
            con.AppointmentConfirmation__c=false;
		update con;	
    }
    //Update confirmation keyword in custom setting
    @AuraEnabled
    public static void updateConfirmKeyword(String confirm)
    {
        sales__c con=[select id, ConfirmationKeyword__c from sales__c Limit 1];
		con.ConfirmationKeyword__c=confirm;
		update con;	
    }
    //Update followup keyword in custom setting		
    @AuraEnabled
    public static void updateFollowUpkeyword(String followUp)
    {
        sales__c con=[select id, FollowupKeyword__c from sales__c Limit 1];
		con.FollowupKeyword__c=followUp;
		update con;	
    }
    //Update Appointment Remainders in custom setting
    @AuraEnabled
    public static void updateAppointmentRemainder(boolean appnmtRemainder,boolean oneh,boolean T4h)
    {
        system.debug(appnmtRemainder);
        sales__c con=[select id,OneHRRemainder__c,T4HRRemainder__c,AppointmentRemaonder__c from sales__c Limit 1];
        if(appnmtRemainder==true)
			con.AppointmentRemaonder__c=true;
        else
            con.AppointmentRemaonder__c=false;
        if(oneh==true)
			con.OneHRRemainder__c=true;
        else
            con.OneHRRemainder__c=false;
        if(T4h==true)
			con.T4HRRemainder__c=true;
        else
            con.T4HRRemainder__c=false;
        update con;
    }
}