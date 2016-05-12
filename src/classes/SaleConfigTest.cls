@isTest
public class SaleConfigTest {
	//for testing Appointment COnfirmation Checkbox
    @isTest
    public static void testupdateSendapnmt1()
    {
    	sales__c testdata=new sales__c();
        insert testdata;
        SalesConfigHandler.updateSendapnmt(true);
        sales__c con=[select id, AppointmentConfirmation__c from sales__c Limit 1];
        System.assertEquals(true,con.AppointmentConfirmation__c);
    }
    //for testing Appointment COnfirmation Checkbox
    @isTest
    public static void testupdatesendapnmt2()
    {
    	sales__c testdata=new sales__c();
        insert testdata;
        SalesConfigHandler.updateSendapnmt(false);
        sales__c con=[select id, AppointmentConfirmation__c from sales__c Limit 1];
        System.assertEquals(false,con.AppointmentConfirmation__c);
    }
    //for testing confirmation keyword updation
    @isTest
    public static void testupdateConfirmKeyword()
    {
        String confirm='Yes';
        sales__c testdata=new sales__c();
        insert testdata;
        
        SalesConfigHandler.updateConfirmKeyword(confirm);
        sales__c con=[select id, ConfirmationKeyword__c from sales__c Limit 1];
        System.assertEquals('Yes', con.ConfirmationKeyword__c);
    }
    //for testing followup keyword testing
    @isTest
    public static void testupdateFollowUpkeyword()
    {
        String followUp='No';
        sales__c testdata=new sales__c();
        insert testdata;    
        SalesConfigHandler.updateFollowUpkeyword(followUp);
        
        sales__c con=[select id, FollowupKeyword__c from sales__c Limit 1];
        System.assertEquals('No', con.FollowupKeyword__c);
    }
    //for testing Appointment Remainder updation;
    @isTest
    public Static void testupdateAppointmentRemainder1()
    {
		sales__c testdata=new sales__c();
        insert testdata;    
        SalesConfigHandler.updateAppointmentRemainder(true,true,true);
        
        sales__c con=[select id, AppointmentRemaonder__c,OneHRRemainder__c,T4HRRemainder__c from sales__c Limit 1];
        System.assertEquals(true, con.AppointmentRemaonder__c);
        System.assertEquals(true,con.OneHRRemainder__c);
        System.assertEquals(true,con.T4HRRemainder__c);
    }
    @isTest
    public Static void testupdateAppointmentRemainder2()
    {
		sales__c testdata=new sales__c();
        insert testdata;    
        SalesConfigHandler.updateAppointmentRemainder(false,false,false);
        
        sales__c con=[select id, AppointmentRemaonder__c,OneHRRemainder__c,T4HRRemainder__c from sales__c Limit 1];
        System.assertEquals(false, con.AppointmentRemaonder__c);
        System.assertEquals(false,con.OneHRRemainder__c);
        System.assertEquals(false,con.T4HRRemainder__c);
    }
}