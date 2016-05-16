@isTest
public class TestClassForSalesforceBanner {
   
    //Check for Account Object
    /*Description - Purpose of this method is call every methods of vf page and assign value to every selectoption*/
    public static Testmethod void checkForData()
    {
        SalesforceBannerController controller = new SalesforceBannerController();
        controller.getListOfObjects();
        controller.getBTypeList();
        controller.getdOptoutFieldList();
        controller.objects = 'Account';
        controller.populateFields();
        controller.buttonLabel = 'testData';
        controller.buttonType = 'Single';
        controller.defaultOptoutField = 'Yes';
        controller.optOutField = '';
        controller.createButton();
     }
    //check for Same label
    /*Description -Purpose of this method is to call createButton two times for same label */
    public static testMethod void checkForCreateButtonExceptions()
    {
        SalesforceBannerController controller = new SalesforceBannerController();
        controller.buttonLabel = 'testData';
        controller.createButton();
        
    }
    //Assign the value of Object as 'NONE'
    public static testMethod void checkForNoneObject()
    {
       	SalesforceBannerController controller = new SalesforceBannerController();
        controller.objects = 'NONE';
        controller.getMphonelist();
        controller.getOptOutFieldList();
        controller.getBTypeList();
        controller.getListOfObjects();
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