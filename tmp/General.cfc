component{	function preHandler(event,action,eventArguments,rc,prc){

	}
	
	function postHandler(event,action,eventArguments,rc,prc){

	}
	
	function aroundHandler(event,targetAction,eventArguments,rc,prc){

		// executed targeted action
		var results = arguments.targetAction(event,event.getCollection(),event.getCollection(private=true));
		
		if( !isNull( results ) ){ return results; }
	}
	
	function onMissingAction(event,missingAction,eventArguments,rc,prc){

	}
	
	function onError(event,faultAction,exception,eventArguments,rc,prc){

	}		
}