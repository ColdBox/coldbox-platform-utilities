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

<cfscript>
generators = [
"increment","identity","sequence","native","assigned","foreign","seqhilo","uuid","guid","select","sequence-identiy"
];
</cfscript>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="orm/ORMEntityGenerator.cfm"> 
		<dialog width="700" height="550" title="ColdFusion ORM Entity Wizard" image="includes/images/ColdBox_Icon.png">  
			
			<input name="Name" label="Entity Name" required="true"  type="string" default="" 
				   tooltip="Enter name of entity without .cfc"
				   helpmessage="Enter name of entity without .cfc" />
		
			<input name="Table" label="Table" type="string" default="" 
				   tooltip="Enter the name of the mapped table or empty for same as entity name"
				   helpmessage="Enter the name of the mapped table or empty for same as entity name" />					
			
			<input name="activeEntity" label="Inherit ActiveEntity" type="boolean" checked="false" 
				   tooltip="Make is extend from the ColdBox ActiveEntity class."
				   helpmessage="Make is extend from the ColdBox ActiveEntity class." />
			
			<input name="Script" label="Script Based CFC" type="boolean" checked="true" 
				   tooltip="Choose whether to create the cfc in pure script or not."
				   helpmessage="Choose whether to create the cfc in pure script or not." />
			
			<input name="primaryKey" label="Primary Key" required="false"  type="string" default="" 
				   tooltip="Enter the name of the primary key"
				   helpmessage="Enter the name of the primary key" />					
			
			<input name="primaryKeyColumn" label="Primary Key Column" required="false"  type="string" default="" 
				   tooltip="Enter the name of the primary key column. Leave blank if same as key."
				   helpmessage="Enter the name of the primary key column. Leave blank if same as key." />					
			
			<input name="primaryKeyGenerator" label="Primary Key Generator" type="list" default="Native">
			<cfloop array="#generators#" index="thisGen">
				<option value="#thisGen#" />
			</cfloop> 
			</input>
			
			<input name="properties" label="Properties (name:type)" type="string" default="" 
				   tooltip="Enter a list of of properties to generate. Ex: name:string,age:numeric"
				   helpmessage="Enter a list of of properties to generate. Ex: name:string,age:numeric"/>
			
		</dialog>
	</ide>
</response>  
</cfoutput>

 