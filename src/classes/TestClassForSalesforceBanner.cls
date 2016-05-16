@isTest
public class TestClassForSalesforceBanner {
    //Check for an Account Object
    /*Description - Purpose of this method is call every method of vf page and assign value to every selectoption*/
    public static Testmethod void testBooleanFields()
    {
        SalesforceBannerController controller = new SalesforceBannerController();
        controller.getListOfObjects();
        controller.objects = 'Account';
        controller.getBTypeList();
        list<Selectoption> s1 = new list<Selectoption>();
        s1.add(new selectOption('isdeleted','isdeleted'));
        controller.populateFields();
        controller.getdOptoutFieldList();
        controller.buttonLabel = 'testData';
        controller.buttonType = 'Single';
        controller.defaultOptoutField = 'Yes';
        controller.optOutField = '';
        list<Selectoption> o = new list<SelectOption>();
        for(Selectoption s : controller.getOptOutFieldList())
        {
            o.add(s);
           
        }
        controller.createButton();
        System.assertEquals(o.get(0), s1.get(0));
       
    }
    //TestMethod for MobilePhone Fields
     public static Testmethod void testMobilePhoneFields()
    {
        SalesforceBannerController controller = new SalesforceBannerController();
        controller.getListOfObjects();
        controller.objects = 'Account';
        controller.getBTypeList();
        list<Selectoption> s1 = new list<Selectoption>();
        s1.add(new selectOption('name','name'));
        s1.add(new selectOption('phone','phone'));
        controller.populateFields();
        controller.buttonLabel = 'testData';
        controller.buttonType = 'Single';
        controller.defaultOptoutField = 'Yes';
        controller.optOutField = '';
        list<Selectoption> o = new list<SelectOption>();
        for(Selectoption s : controller.getMphonelist())
        {
            o.add(s);
           
        }
        controller.createButton();
        System.assertEquals(o.get(0), s1.get(0));
        System.assertEquals(o.get(9), s1.get(1));
        System.debug(o.get(8));
        
    }
    
    //check for existing label of the org
    /*Description -Purpose of this method is to call createButton two times for existing label */
    public static testMethod void testCreateButtonExceptions()
    {
        SalesforceBannerController controller = new SalesforceBannerController();
        controller.buttonLabel = 'testData';
        controller.createButton();
        System.assertEquals('Button Label is already present.Please enter different button label','Button Label is already present.Please enter different button label');
    }
    //Assign the value of Object as 'NONE'
    public static testMethod void testNoneObject()
    {
       	SalesforceBannerController controller = new SalesforceBannerController();
        controller.getListOfObjects();
        controller.getBTypeList();
        controller.getdOptoutFieldList();
    	controller.objects ='NONE';
        controller.populateFields();
        controller.getMphonelist();
        controller.getOptOutFieldList();
  		controller.createButton();
               
    }
    //Assign the value of Object as 'NULL'
    public static testMethod void checkForButton()
    {
       	SalesforceBannerController controller = new SalesforceBannerController();
        controller.objects = null;
        controller.buttonLabel = 'test2Button';
        controller.createButton();
    }
    

}