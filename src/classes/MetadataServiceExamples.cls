public class MetadataServiceExamples

{  
     public static void handleSaveResults(MetadataService.SaveResult saveResult)
    {
        // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!saveResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }
    
    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        System.debug('UserInfo.getSessionId()' + UserInfo.getSessionId());
        return service;
    }
   
    public class MetadataServiceExamplesException extends Exception { }
    
     public static void createButton(string objectName ,string code,string name)
    {
       
        MetadataService.MetadataPort service = createService();
        MetadataService.WebLink webLink = new MetadataService.WebLink();
        webLink.fullName = objectName + '.' + name+'MetaData'; 
        webLink.availability = 'online';
        webLink.displayType = 'button';
        webLink.encodingKey = 'UTF-8';
        webLink.linkType = 'url';
        webLink.masterLabel =  name;
        webLink.openType = 'onClickJavaScript';
        webLink.protected_x = false;
        webLink.url = code;
        handleSaveResults(
            service.createMetadata(
                new List<MetadataService.Metadata> { webLink })[0]);
    }
   
    }