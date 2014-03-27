component accessors="true"{

	property name="data";
	property name="utility";

	function init( required data ){
		variables.utility 	= createObject( "component", "cpu.model.util.Utility" );
		variables.data		= arguments.data;
		return this;
	}

	function getCallBackURL(){
		if( NOT structIsEmpty( data ) AND structKeyExists( data.event.ide, "callbackURL" ) ){
			return data.event.ide.callbackURL.XMLText;
		}
		return "";
	}

	function parseInput( required eventData ){
		var extXMLInput = "";
		var inputStruct = StructNew();
		var i = 1;

		/**
		if( isStruct(arguments.eventData) ){
			return inputStruct;
		}
		*/

		if( server.coldfusion.productname eq "Railo" and !isXML( arguments.eventData ) ){
			return inputStruct;
		}
		else if( server.coldfusion.productname neq "Railo" and isStruct( arguments.eventData ) ){
			return inputStruct;
		}

		extXMLInput = xmlSearch(arguments.eventData, "/event/user/input");

		for(i=1; i lte arrayLen(extXMLInput); i++){
			StructInsert(inputStruct,"#extXMLInput[i].xmlAttributes.name#","#extXMLInput[i].xmlAttributes.value#");
		}

		return inputStruct;
	}

	function getProjectInfo(){
		var p = {
			projectLocation = "", projectName = ""
		};
		if( structKeyExists( data.event.ide, "projectView" ) ){
			p = data.event.ide.projectView.XMLAttributes;
		}
		return p;
	}

	function getProjectResource(){
		var p = {
			path = "", type = ""
		};
		if( structKeyExists( data.event.ide.projectView, "resource" ) ){
			p = data.event.ide.projectView.resource.XMLAttributes;
		}
		return p;
	}

	function getProjectServerInfo(){
		var p = {
			hostname = "", name = "", port = "", wwwroot = ""
		};
		if( structKeyExists( data.event.ide.projectview, "server" ) ){
			p = variables.data.event.ide.projectview.server.xmlAttributes;
		}
		return p;
	}

	function getExtensionLocation(){
		return expandPath( "/cpu" );
	}

	function getBaseURL(){
		return replaceNoCase( variables.utility.getURLBasePath(), "handlers", "" );
	}

	function sendCommand( required xml, callBack=getCallBackURL() ){
		var httpcall = new http( method="post", url=arguments.callback);
		httpcall.addParam( type="body", value=arguments.xml );

		return httpcall.send().getPrefix();
	}

	function refreshProject( required projectName, callBackURL=getCalBackURL() ){
		var commandXML = "";

		savecontent variable="commandXML"{
			writeOutput('
			<response>
			<ide>
			    <commands>
			        <command type="refreshProject">
						 <params>
						  	<param key="projectname" value="#arguments.projectName#" />
						 </params>
						</command>
			    </commands>
			</ide>
			</response>
			');
		};

		thread name="callbackCommandCPU" commandXML="#commandXML#" callbackURL="#arguments.callbackURL#"{
			sendCommand( attributes.commandXML, attributes.callbackURL );
		};
	}

	/**
	* Must be used from within the project view context
	*/
	function getBundleURL( required target ){
		var projectLocation = replace( getProjectInfo().projectLocation, "\", "/", "all" );

		// case 1: cpu.json -> build runner from global cpu.json file
		if( fileExists( projectLocation & "/cpu.json" ) ){
			var cpudata 	= deserializeJSON( fileRead( projectLocation & "/cpu.json" ) );
			var bundlePath 	= reReplace( replacenocase( arguments.target, projectLocation, '' ), "^/", "" );

			if( structKeyExists( cpudata, "projectURL" ) ){
				// cleanup
				if( !refind( "\/$", cpudata.projectURL ) ){ cpudata.projectURL &= "/"; }
				return cpudata.projectURL & bundlePath;
			}
			// else, continue trying to find it.
		}

		// case 2: server info -> build runner URL from server information
		// create host + port URL path if server exists, else leave blank for user to add
		if( structKeyExists( variables.data.event.ide.projectview, "server" ) ){
			// create host + port URL path
			var urlPath = "http://" & variables.data.event.ide.projectview.server.xmlAttributes.hostname & ":" & variables.data.event.ide.projectview.server.xmlAttributes.port;
			// cleanup the wwwroot from the resource targeted
			var bundlePath = replacenocase( arguments.target,
											variables.data.event.ide.projectview.server.XMLAttributes.wwwroot,
											'' );
			return urlPath & bundlePath;
		}

		var bundlePath = replacenocase( arguments.target, projectLocation, '' );

		// case 3: Default via locations, up to user to correct.
		return "http://localhost/#listLast( projectLocation, "/")##bundlePath#";
	}

	/**
	* Must be used from within the project view context: for now.
	*/
	function getTestBoxRunner( target ){
		var projectLocation = replace( getProjectInfo().projectLocation, "\", "/", "all" );

		// case 1: cpu.json -> build runner from global cpu.json file
		if( fileExists( projectLocation & "/cpu.json" ) ){
			var cpudata 	= deserializeJSON( fileRead( projectLocation & "/cpu.json" ) );
			if( structKeyExists( cpudata, "testbox" ) && structKeyExists( cpudata.testbox, "runnerURL" ) ){
				return cpudata.testbox.runnerURL;
			}
			// else, continue trying to find it.
		}

		// case 2: server info -> build runner URL from server information
		if( structKeyExists( variables.data.event.ide.projectview, "server" ) ){
			var serverInfo = getProjectServerInfo();
			// create host + port URL path
			return "http://" & serverInfo.hostname & ":" & serverInfo.port & "/coldbox/system/testing/TestBox.cfc";
		}

		// case 3: Default via locations, up to user to correct.
		return "http://localhost/coldbox/system/testing/TestBox.cfc";
	}

}