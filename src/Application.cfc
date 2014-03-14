/**
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
**/
component{
	// App Properties
	this.name				= "CPU_#hash( getCurrentTemplatePath() )#";
	this.sessionManagement	= true;

	// Local Mappings for Extension
	this.mappings[ "/cpu" ] = getDirectoryFromPath( getCurrentTemplatePath() );

	/**
	* On Request Start
	*/
	function onRequest( required targetPage ){
		param name="ideeventinfo" 	default="";
		param name="data" 			default="#{}#";

		//writedump( var="Executing #cgi.script_name# #timeFormat(now())#", output="console" );
		//writedump( var="ideeventinfo: #ideeventinfo.toString()#", output="console" );
		//writedump( var="data: #data.toString()#", output="console" );

		// parse incomign event info
		if( isXML( ideEventInfo ) ){
			data = xmlParse( ideEventInfo );
		}

		// place the ExtensionController on scope
		controller = getExtensionController( data );
		// Parse the incoming input values
		inputStruct = controller.parseInput( data );

		include "debug.cfm";
		include "#arguments.targetPage#";
	}

	/************************************** PRIVATE *********************************************/

	/**
	* Build extension controller
	*/
	private function getExtensionController( required data ){
		return new cpu.model.ExtensionController( arguments.data );
	}

}