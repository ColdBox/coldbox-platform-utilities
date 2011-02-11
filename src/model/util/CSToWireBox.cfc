<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

CS Converter to WireBox

----------------------------------------------------------------------->
<cfcomponent output="false" hint="CS Converter to WireBox">

	<cffunction name="init" access="public" returnType="CSToWireBox" output="false" hint="Constructor">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
	<!--- convert --->
	<cffunction name="convert" access="public" returntype="struct" hint="Convert to WireBox" output="false" >
		<cfargument name="filePath"	required="true">
		<cfscript>
			var results = {
				errorMessages = "",
				data = ""
			};
			var i 			= 0;
			var xml 		= "";
			var beans 		= "";
			var beanData 	= createObject("java","java.util.Vector").init();
			
			// Parsing
			try{
				csXML = XMLParse(arguments.filePath);
				beans = XMLSearch(csXML,'/beans/bean');
			
				// If no beans
				if( NOT arrayLen(beans) ){
					results.errorMessages = "No bean definitions found";
					return results;
				}			
				
				// loop over beans to create definitions from XML
				for(i = 1; i lte arrayLen(beans); i++){
					translateBean(beans[i], beanData);
				}			
				
				// process into wirebox notation.
				results.data = toWireBox(beanData);
				
			}
			catch(any e){
				results.errorMessages = "Error parsing bean definitions: #e.message# #e.detail# #e.stacktrace#";
			}
			
			return results;
		</cfscript>
	</cffunction>
	
	<!--- toWireBox --->
    <cffunction name="toWireBox" output="false" access="public" returntype="any" hint="Convert to wirebox">
    	<cfargument name="beanData"/>
		<cfscript>
			var buf = createObject("java","java.lang.StringBuffer").init('');
			var cr  = chr(13) & chr(10);
			var tab = repeatString(chr(9),3);
			var beans = arguments.beanData;
			var x	= 1;
			var j	= 1;
			
			for( x=1; x lte arrayLen(beans); x++){
				buf.append('#repeatString(chr(9),2)#map("#beans[x].beanName#")');
				// class?
				if( len(beans[x].fullClassPath) ){ 
					buf.append('.to("#beans[x].fullClassPath#")'); 
					// constructor dependencies
					for(j=1; j lte arrayLen(beans[x].constructorProperties); j++){
						buf.append('#cr##tab#.initArg(name="#beans[x].constructorProperties[j].name#"');
						if( len(beans[x].constructorProperties[j].ref) ){
							buf.append(',ref="#beans[x].constructorProperties[j].ref#"');
						}
						else{
							buf.append(',value="#beans[x].constructorProperties[j].value#"');
						}
						buf.append(")");
					}
					// setter dependencies
					for(j=1; j lte arrayLen(beans[x].setterProperties); j++){
						buf.append('#cr##tab#.setter(name="#beans[x].setterProperties[j].name#"');
						if( len(beans[x].setterProperties[j].ref) ){
							buf.append(',ref="#beans[x].setterProperties[j].ref#"');
						}
						else{
							buf.append(',value="#beans[x].setterProperties[j].value#"');
						}
						buf.append(")");
					}
				}
				// factory methods?
				if( len(beans[x].factoryBean) ){
					buf.append('.toFactoryMethod(factory="#beans[x].factoryBean#",method="#beans[x].factoryMethod#")');
					// dependencies
					for(j=1; j lte arrayLen(beans[x].constructorProperties); j++){
						buf.append('#cr##tab#.methodArg(name="#beans[x].constructorProperties[j].name#"');
						if( len(beans[x].constructorProperties[j].ref) ){
							buf.append(',ref="#beans[x].constructorProperties[j].ref#"');
						}
						else{
							buf.append(',value="#beans[x].constructorProperties[j].value#"');
						}
						buf.append(")");
					}
				}
				// singleton?
				if( beans[x].singleton ){ buf.append('#cr##tab#.asSingleton()'); }
				// Autowire?
				if( NOT beans[x].autowire ){ buf.append('#cr##tab#.noAutowire()'); }
				// Constructor?
				if( len(beans[x].initMethod) ){ buf.append('#cr##tab#.constructor("#beans[x].initMethod#")'); }
				// Lazy?
				if( NOT beans[x].lazy ){ buf.append('#cr##tab#.asEagerInit()'); }
				
				// end declaration;
				buf.append(";#cr#");
			}
		
			return buf.toString();
		</cfscript>    	
    </cffunction>	
	
	<!--- Translate a bean definition --->
	<cffunction name="translateBean" access="private" output="false" returntype="void" hint="I translate ColdSpring XML bean definitiions to LightWire config.">
		<cfargument name="bean" 	type="any" 	required="true"  hint="The xml bean definition. This is an XML object">
		<cfargument name="beanData" type="any" 	required="true"  hint="The bean data array"/>
		<cfscript>
			var beanStruct = StructNew();
			var key 		= "";
			var beanAttributeValue = 0;
			var errormsg = '';
			
			// default bean
			beanStruct = {
				factoryBean = "", factoryMethod = "",
				singleton = true, fullClassPath = "",
				beanName = "", initMethod = "",
				lazy = true,
				constructorProperties = [],
				setterProperties = [],
				autowire = false
			};
			
			// loop over bean tag attributes and create beanStruct keys
			for (key in bean.XmlAttributes){
				// Get Attribute Value
				beanAttributeValue = trim(bean.XMLAttributes[key]);
				// Set Values
				if (key eq "factory-bean"){
					beanStruct.FactoryBean = beanAttributeValue;
				}
				if (key eq "autowire"){
					beanStruct.autowire = beanAttributeValue;
				}
				if (key eq "factory-method"){
					beanStruct.FactoryMethod = beanAttributeValue;
				}
				if (key eq "singleton"){
					beanStruct.Singleton = beanAttributeValue;
				}
				if (key eq "class"){
					beanStruct.FullClassPath = beanAttributeValue;
				}
				if (key eq "id"){
					beanStruct.BeanName = beanAttributeValue;
				}
				if (key eq "init-method"){
					beanStruct.InitMethod = beanAttributeValue;
				}			
				if (key eq "lazy-init"){
					beanStruct.Lazy = beanAttributeValue;
				}
			}//end loop over xml attributes
			
			// Check for a the presence of bean name 
			if(not structKeyExists(beanStruct,"BeanName")){
				errormsg = 'Missing bean name or id in xml declaration';
				if(structKeyExists(beanStruct,"FullClassPath")){
					errormsg = errormsg & ' for object of class #beanStruct.FullClassPath#';
				}else if(structKeyExists(beanStruct,"FactoryBean") and structKeyExists(beanStruct,"FactoryMethod")){
					errormsg = errormsg & ' for object referencing factory bean #beanStruct.FactoryBean# and method #beanStruct.FactoryMethod#';
				}
				getUtil().throwIt(errormsg,'Check config file for id or beanname key on object definition.');
			}
			
			// add constructor dependecies and properties
			beanStruct.constructorProperties = translateBeanChildren(arguments.bean,'constructor-arg',arguments.beanData);
			// add setter dependecies and properties
			beanStruct.setterProperties 	 = translateBeanChildren(arguments.bean,'property',arguments.beanData);
			
			arrayAppend(arguments.beanData, beanStruct);
			
		</cfscript>
	</cffunction>
	
	<!--- Translate bean children --->
	<cffunction name="translateBeanChildren" access="private" output="false" returntype="any">
		<cfargument name="bean" 		type="any" 	required="true" hint="The xml bean definition object">
		<cfargument name="childTagName" type="any" 	required="true" hint="The child tag name to parse">
		<cfargument name="beanData"		type="any" 	required="true"  hint="The bean data array"/>
		<cfscript>
			var children = "";
			var entries = "";
			var hashMap = "";
			var i = 1;
			var j = 1;
			var data = [];
			
			// find all constructor properties and dependencies
			children = XMLSearch(arguments.bean,arguments.childTagName);
			// Loop Over Children	
			for (i = 1; i lte ArrayLen(children); i++){
				data[i] = {
					name = trim(children[i].XmlAttributes["name"]), 
					value="", ref=""
				};
					
				// child element "value"
				if(structKeyExists(children[i],"value")){
					data[i].value = trim(children[i].value.XmlText);
				};
				
				// Map
				if (structKeyExists(children[i],"map")){
					entries = XMLSearch(xmlParse(toString(children[i])),'//map/entry');
					hashMap = structNew();
					for (j = 1; j lte ArrayLen(entries); j++){
						if (structKeyExists(entries[j],"value")){
							hashMap[entries[j].XmlAttributes["key"]] = entries[j].value.XmlText;
						}
					}
					data[i].value = hashMap;
				}; 
				
				// child element "ref"
				if (structKeyExists(children[i],"ref")){
					data[i].ref = children[i].ref.XmlAttributes["bean"];
				};
				
				//child element "bean"
				if (structKeyExists(children[i],"bean")){
				
					// Verify ID exists, else create a unique ID for this nested bean definition
					if( not structKeyExists(children[i].bean.xmlAttributes,"id") ){
						if( structKeyExists(children[i].bean.xmlAttributes,"class") ){
							children[i].bean.xmlAttributes.id = listlast(children[i].bean.xmlAttributes.class,".") & ":" & left(hash(createUUID()),10);
						}
						else{
							children[i].bean.xmlAttributes.id = "anonBean:" & left(hash(createUUID()),10);
						}
					}
					// setup the reference.
					data[i].ref = children[i].bean.xmlAttributes.id;
					
					// Translate it and add it to array definition
					translateBean(children[i].bean,arguments.beanData);
				};
			};
			
			return data;
		</cfscript>
	</cffunction>
	
	<!--- getUtil --->
	<cffunction name="getUtil" output="false" access="private" returntype="any" hint="Get the utility object">
		<cfreturn createObject("component","coldboxExtension.model.util.Utility")>
	</cffunction>

</cfcomponent>
