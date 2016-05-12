({
	"abc": function(component, event) {
        //for updating Appoinrment confirmation
        if(true)	
        {
            var action = component.get("c.updateSendapnmt"); 
            action.setParams({sendApmt:component.get("v.sendAppoint")});
            action.setCallback(this, function(response) {
            });
        	$A.enqueueAction(action);
        }
        //for updating confirmation keyword
        if(component.get("v.updateConfirmation")==true)
        {
            var action = component.get("c.updateConfirmKeyword");
            action.setParams({confirm:component.get("v.confirmationKeyword")});
            action.setCallback(this, function(response) {

            });
        	$A.enqueueAction(action);
        }
        //for updating followup keyword
        if(component.get("v.followuptaskcheck")==true)
        {
            var action = component.get("c.updateFollowUpkeyword");
            action.setParams({followUp:component.get("v.followUpKeyword")});
            action.setCallback(this, function(response) {
            });
        	$A.enqueueAction(action);
        }
        //for updating appointment remainder
        if(true)
        {
       		var action = component.get("c.updateAppointmentRemainder");
            action.setParams({appnmtRemainder:component.get("v.appointmentRemainder"),oneh:component.get("v.onehourprior"),T4h:component.get("v.t4hourprior")});
           	action.setCallback(this, function(response) {
           });
        $A.enqueueAction(action);
        } 
	}, 
    //Enable or disable Confirmkeyword and followkeyword textboxes
     "EnableDisableText" : function(cmp, event) { 
        if (cmp.find("ConfirmKeywordCheck").get("v.value")) {
          cmp.find("confirmationKeyword").set("v.disabled",false);
        }
        else{
             cmp.find("confirmationKeyword").set("v.disabled",true);
        }
         
        if (cmp.find("FollowUpkeyWordCheck").get("v.value")) {
          cmp.find("followUpKeyword").set("v.disabled",false);
        }else{
             cmp.find("followUpKeyword").set("v.disabled",true);
        }
     },
    //Enable or disable appointment remainder options
    "EnableDisableAppointmentRemainder" : function(cmp, event) { 
        if (cmp.find("AppointmentRemainderCheck").get("v.value")) {
          cmp.find("OneHourPrior").set("v.disabled",false);
          cmp.find("T4HourPrior").set("v.disabled",false);  
        }
        else{
            cmp.find("OneHourPrior").set("v.disabled",true);
          	cmp.find("T4HourPrior").set("v.disabled",true);
        }
     }
})