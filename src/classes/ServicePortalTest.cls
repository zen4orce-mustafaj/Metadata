@isTest
public class ServicePortalTest 
{
    
	public static testMethod void SendAppointmentTest()
    { 
        //Inserting Test Data - Custom Setting
        SMSConfiguration__c data = new SMSConfiguration__c();     
        data.Service_Appointment_Confirmation__c=true; 
        insert data;
        
	    ServiceController.SendAppointment(true); 
        SMSConfiguration__c con=[select id, Service_Appointment_Confirmation__c from SMSConfiguration__c Limit 1];
        System.assertEquals(true,con.Service_Appointment_Confirmation__c);
        
        ServiceController.SendAppointment(false);
        SMSConfiguration__c con1=[select id, Service_Appointment_Confirmation__c from SMSConfiguration__c Limit 1];
        System.assertEquals(false,con1.Service_Appointment_Confirmation__c);      
    }
    
    public static testMethod void KeywordTest()
    { 
        //Inserting Test Data - Custom Setting
        SMSConfiguration__c data = new SMSConfiguration__c();
        data.Confirmation_Keyword__c = 'Yes';
        data.Follow_up_keyword__c = 'Maybe';
        data.Service_Appointment_Confirmation__c=true;
        insert data;
        
	    ServiceController.updatebothKeyword('Yes', 'Maybe');
        SMSConfiguration__c con=[select id, Confirmation_Keyword__c,Follow_up_keyword__c from SMSConfiguration__c Limit 1];
        System.assertEquals('Yes',con.Confirmation_Keyword__c);
        System.assertEquals('Maybe',con.Follow_up_keyword__c);
        
        ServiceController.updatebothKeyword(Null, Null);
        SMSConfiguration__c con1=[select id, Confirmation_Keyword__c,Follow_up_keyword__c from SMSConfiguration__c Limit 1];
        System.assertEquals(Null,con1.Confirmation_Keyword__c);
        System.assertEquals(Null,con1.Follow_up_keyword__c);
               
    }
    
    public static testMethod void SendRemainderTesttrueCheck()
    { 
        //Inserting Test Data - Custom Setting
        SMSConfiguration__c data = new SMSConfiguration__c();
        data.Confirmation_Keyword__c = 'Yes';
        data.Follow_up_keyword__c = 'Maybe';
        data.Name='test data';
        data.Service_Appointment_Confirmation__c=true;
        data.Service_Appointment_Reminder__c = True;
        data.X1_Hour_Reminder__c = true;
        data.X24_Hour_Reminder__c = true;
        insert data;
         
	    ServiceController.ServiceReminder(true);
        ServiceController.x1HourReminder(true);
        ServiceController.x24HourReminder(true);
        
        SMSConfiguration__c con=[select id, Service_Appointment_Reminder__c,X1_Hour_Reminder__c,X24_Hour_Reminder__c from SMSConfiguration__c Limit 1];
        System.assertEquals(true,con.Service_Appointment_Reminder__c);
        System.assertEquals(true,con.X1_Hour_Reminder__c);
        System.assertEquals(true,con.X24_Hour_Reminder__c);
        
            
    }
    
     public static testMethod void SendRemainderTestFalseCheck()
    {
        //Inserting Test Data - Custom Setting
        SMSConfiguration__c data = new SMSConfiguration__c();
        data.Service_Appointment_Reminder__c = false;
        data.X1_Hour_Reminder__c = false;
        data.X24_Hour_Reminder__c = false;
        insert data;
        
        ServiceController.ServiceReminder(false);
        ServiceController.x1HourReminder(false);
        ServiceController.x24HourReminder(false);
        SMSConfiguration__c con1=[select id, Service_Appointment_Reminder__c,X1_Hour_Reminder__c,X24_Hour_Reminder__c from SMSConfiguration__c Limit 1];
        System.assertEquals(false,con1.Service_Appointment_Reminder__c);
        System.assertEquals(false,con1.X1_Hour_Reminder__c);
        System.assertEquals(false,con1.X24_Hour_Reminder__c);  
    }
  
}