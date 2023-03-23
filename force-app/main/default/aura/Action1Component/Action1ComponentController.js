({
	myAction : function(component, event, helper) {
        var recordId = component.get('v.recordId');
        var action = component.get('c.getValue');
        action.setParams({'recordId': recordId});
        action.setCallback(this, function(response) {
            console.log('------------------------------');
            console.log(response.getReturnValue());
            console.log('------------------------------');
            $A.get("e.force:closeQuickAction").fire();
        });
        $A.enqueueAction(action);
	}
})