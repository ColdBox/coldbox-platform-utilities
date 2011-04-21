<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Author 	 :	Luis Majano
Description :
	Your WireBox Configuration Binder
----------------------------------------------------------------------->
<cfcomponent output="false" hint="The default WireBox Injector configuration object" extends="coldbox.system.ioc.config.Binder">
<cfscript>
	
	/**
	* Configure WireBox, that's it!
	*/
	function configure(){
		
		// The WireBox configuration structure DSL
		wireBox = {
			// Scope registration, automatically register a wirebox injector instance on any CF scope
			// By default it registeres itself on application scope
			scopeRegistration = {
				enabled = true,
				scope   = "application", // server, cluster, session, application
				key		= "wireBox"
			},

			// DSL Namespace registrations
			customDSL = {
				// namespace = "mapping name"
			},
			
			// Custom Storage Scopes
			customScopes = {
				// annotationName = "mapping name"
			},
			
			// Package scan locations
			scanLocations = [],
			
			// Stop Recursions
			stopRecursions = [],
			
			// Parent Injector to assign to the configured injector, this must be an object reference
			parentInjector = "",
			
			// Register all event listeners here, they are created in the specified order
			listeners = [
				// { class="", name="", properties={} }
			]			
		};
		
		// Map Bindings below
		map("ColdboxFactory").to("coldbox.system.ioc.ColdboxFactory")
			.asSingleton()
			.noAutowire();
		map("datasourceBean").toFactoryMethod(factory="ColdBoxFactory",method="getDatasource")
			.methodArg(name="alias",value="coldboxreader")
			.asSingleton()
			.noAutowire();
		map("feedReader").toFactoryMethod(factory="ColdBoxFactory",method="getPlugin")
			.methodArg(name="plugin",value="feedReader")
			.methodArg(name="plugin",value="feedReader")
			.asSingleton()
			.noAutowire();
		map("anonBean:E609998BAF").toFactoryMethod(factory="TransferConfigFactory",method="getTransferConfig")
			.methodArg(name="configPath",value="${Transfer_configPath}")
			.methodArg(name="definitionPath",value="${Transfer_definitionPath}")
			.methodArg(name="dsnBean",ref="CodexDatasource")
			.asSingleton()
			.noAutowire();
		map("TransferFactory").to("transfer.TransferFactory")
			.initArg(name="configuration",ref="anonBean:E609998BAF")
			.asSingleton()
			.noAutowire();
		map("feedDAO").to("coldbox.samples.applications.ColdBoxReader.components.dao.feed")
			.initArg(name="dsnBean",ref="datasourceBean")
			.noAutowire();
		map("feedService").to("coldbox.samples.applications.ColdBoxReader.components.services.feedService")
			.initArg(name="feedDAO",ref="feedDAO")
			.initArg(name="ModelBasePath",value="${ModelBasePath}")
			.initArg(name="feedReader",ref="feedReader")
			.asSingleton()
			.noAutowire();
		map("tagDAO").to("coldbox.samples.applications.ColdBoxReader.components.dao.tags")
			.initArg(name="dsnBean",ref="datasourceBean")
			.noAutowire();
		map("tagService").to("coldbox.samples.applications.ColdBoxReader.components.services.tagService")
			.initArg(name="tagDAO",ref="tagDAO")
			.initArg(name="ModelBasePath",value="${ModelBasePath}")
			.asSingleton()
			.noAutowire();
		map("usersDAO").to("coldbox.samples.applications.ColdBoxReader.components.dao.users")
			.initArg(name="dsnBean",ref="datasourceBean")
			.noAutowire();
		map("userBean").to("coldbox.samples.applications.ColdBoxReader.components.beans.userBean")
			.noAutowire();
		map("userService").to("coldbox.samples.applications.ColdBoxReader.components.services.userService")
			.initArg(name="usersDAO",ref="usersDAO")
			.initArg(name="ModelBasePath",value="${ModelBasePath}")
			.initArg(name="OwnerEmail",value="${OwnerEmail}")
			.asSingleton()
			.noAutowire();

	}	
</cfscript>
</cfcomponent>