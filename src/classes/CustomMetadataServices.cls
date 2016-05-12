public class CustomMetadataServices {
    
     public static void createWebLink(string objectName,string code,string buttonFullName, string buttonLabel)
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.WebLink webLink = new MetadataService.WebLink();
        webLink.fullName = objectName + '.' + buttonFullName;
        webLink.availability = 'online';
        webLink.displayType = 'button';
        webLink.encodingKey = 'UTF-8';
        webLink.linkType = 'javascript';
        webLink.masterLabel = buttonLabel;
        webLink.openType = 'onClickJavaScript';
        webLink.protected_x = false;
        weblink.url = code;
        List<MetadataService.SaveResult> results =
            service.createMetadata(
                new MetadataService.Metadata[] { webLink });
        handleSaveResults(results[0]);
    }
    
     public static void readAndUpdateLayout(string objectName,string code,string buttonFullName, string buttonLabel)
    {
        MetadataService.MetadataPort service = createService();

        // Create Button
        MetadataService.WebLink webLink = new MetadataService.WebLink();
        webLink.fullName = objectName + '.' + buttonFullName;
        webLink.availability = 'online';
        webLink.displayType = 'button';
        webLink.encodingKey = 'UTF-8';
        webLink.linkType = 'url';
        webLink.masterLabel = buttonLabel;
        webLink.openType = 'onClickJavaScript';
        webLink.protected_x = false;
        webLink.url = code;
        handleSaveResults(
            service.createMetadata(
                new List<MetadataService.Metadata> { webLink })[0]);

        // Read the Layout
        MetadataService.Layout layout =
            (MetadataService.Layout) service.readMetadata('Layout',
                new String[] { 'Account-Account Layout' }).getRecords()[0];

        // Add the Custom Button to the Layout
        if(layout.customButtons==null)
            layout.customButtons = new List<String>();
        layout.customButtons.add(buttonFullName);

        // Update the Layout
        handleSaveResults(
            service.updateMetadata(
                new MetadataService.Metadata[] { layout })[0]);
    }
	public class CustomMetadataServicesException extends Exception { }

    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        System.debug('UserInfo.getSessionId()' + UserInfo.getSessionId());
        return service;
    }

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
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
                throw new CustomMetadataServicesException(String.join(messages, ' '));
        }
        if(!saveResult.success)
            throw new CustomMetadataServicesException('Request failed with no specified error.');
    }

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
    public static void handleDeleteResults(MetadataService.DeleteResult deleteResult)
    {
        // Nothing to see?
        if(deleteResult==null || deleteResult.success)
            return;
        // Construct error message and throw an exception
        if(deleteResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (deleteResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + deleteResult.fullName + '.');
            for(MetadataService.Error error : deleteResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new CustomMetadataServicesException(String.join(messages, ' '));
        }
        if(!deleteResult.success)
            throw new CustomMetadataServicesException('Request failed with no specified error.');
    }

    /**
     * Example helper method to interpret a UpsertResult, throws an exception if errors are found
     **/
    public static void handleUpsertResults(MetadataService.UpsertResult upsertResult)
    {
        // Nothing to see?
        if(upsertResult==null || upsertResult.success)
            return;
        // Construct error message and throw an exception
        if(upsertResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (upsertResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + upsertResult.fullName + '.');
            for(MetadataService.Error error : upsertResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new CustomMetadataServicesException(String.join(messages, ' '));
        }
        if(!upsertResult.success)
            throw new CustomMetadataServicesException('Request failed with no specified error.');
    }
}