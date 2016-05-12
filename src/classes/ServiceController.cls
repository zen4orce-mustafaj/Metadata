public with sharing class ServiceController 
{
    //AURA ENABLED METHODS ON SERVER SIDE.
    //
    //METHOD TO UPDATE KEYWORDS IN CUSTOM SETTING.
    @AuraEnabled
    public static void updatebothKeyword(String confirm, String followUp)
    {
        SMSConfiguration__c con=[select id, Confirmation_Keyword__c,Follow_up_keyword__c from SMSConfiguration__c Limit 1];
        if(confirm != Null)
        {
            con.Confirmation_Keyword__c = confirm;
        }
  		else
        {
            con.Confirmation_Keyword__c = null;
        }
        
        if(followUp != Null)
        {
             con.Follow_up_keyword__c=followUp;
        }
        else
        {
             con.Follow_up_keyword__c=null;
        } 
  		update con; 
        System.debug('after update ' +confirm);
        System.debug('after update ' +followUp);
          
    }

    //METHOD TO UPDATE APPOINMENT CHECKBOX IN CUSTOM SETTING.
    @AuraEnabled
    public static void SendAppointment(Boolean SendAppointmentCheck)
    {
        SMSConfiguration__c con=[select id, Service_Appointment_Confirmation__c from SMSConfiguration__c Limit 1];
        if(SendAppointmentCheck==True){
            con.Service_Appointment_Confirmation__c=SendAppointmentCheck;
        }
        else
        {
            con.Service_Appointment_Confirmation__c=False;
        }

  		update con;     
    }
    
    //METHOD TO UPDATE 1 HOUR REMINDER CHECKBOX IN CUSTOM SETTING.
    @AuraEnabled
    public static void x1HourReminder(Boolean x1hr)
    {
        SMSConfiguration__c con=[select id, X1_Hour_Reminder__c from SMSConfiguration__c Limit 1];
        if(x1hr==True)
        {
            con.X1_Hour_Reminder__c=x1hr;
        }
        else
        {
            con.X1_Hour_Reminder__c=False;
        }
  		update con;     
    }
    
    //METHOD TO UPDATE 24 HOUR REMINDER CHECKBOX IN CUSTOM SETTING.
    @AuraEnabled
    public static void x24HourReminder(Boolean x24hr)
    {
        SMSConfiguration__c con=[select id, X24_Hour_Reminder__c from SMSConfiguration__c Limit 1];
        if(x24hr==True)
        {
            con.X24_Hour_Reminder__c=x24hr;
        }
        else
        {
            con.X24_Hour_Reminder__c=False;
        }
  		update con;    
    }
    
    //METHOD TO UPDATE REMINDER CHECKBOX IN CUSTOM SETTING.
    @AuraEnabled
    public static void ServiceReminder(Boolean ServiceAReminder)
    {
        SMSConfiguration__c con=[select id, Service_Appointment_Reminder__c from SMSConfiguration__c Limit 1];
        if(ServiceAReminder==True)
        {
            con.Service_Appointment_Reminder__c=ServiceAReminder;
        }
        else
        {
            con.Service_Appointment_Reminder__c=False;
        }
  		update con;
    }  
}