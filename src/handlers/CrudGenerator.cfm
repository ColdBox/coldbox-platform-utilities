<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah & Luis Majano

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->
<cfsavecontent variable="commandXML" > 
<cfoutput> 
    <response> 
        <ide> 
            <commands> 
                <command type="getfunctionsandvariables" > 
					<params> 
				  		<param key="filePath" value="#data.event.ide.projectView.resource.xmlAttributes.path#"/> 
				 	</params> 
				</command>
            </commands>     
        </ide> 
    </response> 
</cfoutput> 
</cfsavecontent>
<cfscript>
	r = controller.sendCommand(commandXML);
	writeDump(r);abort;
</cfscript>

 