({
    // CLINT SIDE FUNCTION FOR GEI=TTING VALUE OF ALL FIELDS
    "getInput" : function(cmp, event) {
        if(cmp.get("v.Updateonconfirmation") == "undefined" && cmp.get("v.followuptask") == "undefined")
        {
            cmp.set("v.Updateonconfirmation", false);
            cmp.set("v.followuptask", false);
       	}
           //GETTING VALUE OF KEYWORD FIELD
           var action = cmp.get("c.updatebothKeyword");  //method
           action.setParams({confirm:cmp.get("v.confirmkeyword"), followUp:cmp.get("v.Followupkeyword")});
           action.setCallback(this, function(response)
           {
            	var state = response.getState();
				if(state=="SUCCESS")
          		{
                	alert("Done!");
            	}
            	else
                {
                    alert("From server: " + response.getReturnValue());
                }
           });
           $A.enqueueAction(action);
            
        //GETTING VALUE OF CONFIRMATION FIELD
        if(cmp.get("v.AppointmentConfirmation")!= "undefined" || cmp.get("v.AppointmentConfirmation")!= null )
        {
            var action = cmp.get("c.SendAppointment");  // Method 
            action.setParams({SendAppointmentCheck:cmp.get("v.AppointmentConfirmation")});
            action.setCallback(this, function(response){
            });
        	$A.enqueueAction(action);
        }
        else{ cmp.set("v.AppointmentConfirmation", false);}
        
        //GETTING VALUE OF 1 HOUR REMINDER FIELD
        if(cmp.get("v.x1Hourprior")!= "undefined" || cmp.get("v.x1Hourprior")!= null)
        {
            var action = cmp.get("c.x1HourReminder");  // Method 
            action.setParams({x1hr:cmp.get("v.x1Hourprior")});
            action.setCallback(this, function(response){
            });
        	$A.enqueueAction(action);
        }
        else{ cmp.set("v.x1Hourprior", false);}
        //GETTING VALUE OF 24 HOUR REMINDER FIELD
        if(cmp.get("v.x24Hourprior")!= "undefined" || cmp.get("v.x24Hourprior")!= nul)
        {
            var action = cmp.get("c.x24HourReminder");  // Method 
            action.setParams({x24hr:cmp.get("v.x24Hourprior")});
            action.setCallback(this, function(response){
            });
        	$A.enqueueAction(action);
        }
        else{ cmp.set("v.x24Hourprior", false);}
        
        //GETTING VALUE OF REMINDER CHECKBOX FIELD
        if(cmp.get("v.SendAppointmentReminder")!= "undefined" || cmp.get("v.SendAppointmentReminder")!= nul)
        {
            var action = cmp.get("c.ServiceReminder");  // Method 
            action.setParams({ServiceAReminder:cmp.get("v.SendAppointmentReminder")});
            action.setCallback(this, function(response){
            });
        	$A.enqueueAction(action);
        }
        else{ cmp.set("v.SendAppointmentReminder", false);}
    },
     
     //FUNCTION FOR ENABLE OR DISABLE TEXT (KEYWORD) FIELD
     "EnableDisableText" : function(cmp, event) { 
        if (cmp.find("checkbox").get("v.value")) {
       			cmp.find("textbox").set("v.disabled",false);
        }else{
            	cmp.find("textbox").set("v.disabled",true);
        }
        if (cmp.find("checkbox1").get("v.value")) {
       			cmp.find("textbox1").set("v.disabled",false);
        }else{
            	cmp.find("textbox1").set("v.disabled",true);
        }
    },
    
     //FUNCTION FOR ENABLE OR DISABLE REMINDER CHECKBOX FIELD
     "EnableDisableChekbox" : function(cmp, event) { 
        if (cmp.find("SendAppoinment").get("v.value")) 
        {
       			cmp.find("x1hr").set("v.disabled",false);
            	cmp.find("x24hr").set("v.disabled",false);
        }else{
            	cmp.find("x1hr").set("v.disabled",true);
            	cmp.find("x24hr").set("v.disabled",true);
        }  
    }
 })