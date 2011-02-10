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
		map("ColdboxFactory").to("coldbox.system.extras.ColdboxFactory")
			.asSingleton()
			.noAutowire();
		map("ColdBoxController").toFactoryMethod(factory="ColdBoxFactory",method="getColdBox")
			.asSingleton();
		map("InterceptorService").toFactoryMethod(factory="ColdBoxController",method="getinterceptorService")
			.asSingleton();
		map("ConfigBean").toFactoryMethod(factory="ColdBoxFactory",method="getConfigBean")
			.asSingleton();
		map("ColdboxOCM").toFactoryMethod(factory="ColdboxFactory",method="getColdBoxOCM")
			.asSingleton();
		map("BeanInjector").toFactoryMethod(factory="ColdBoxFactory",method="getPlugin")
			.methodArg(name="plugin",value="beanFactory")
			.asSingleton();
		map("sessionstorage").toFactoryMethod(factory="ColdboxFactory",method="getPlugin")
			.methodArg(name="plugin",value="sessionstorage")
			.asSingleton();
		map("TransferConfigFactory").to("coldbox.system.extras.transfer.TransferConfigFactory")
			.asSingleton();
		map("TDOBeanInjectorObserver").to("coldbox.system.extras.transfer.TDOBeanInjectorObserver")
			.initArg(name="Transfer",ref="Transfer")
			.initArg(name="ColdBoxBeanFactory",ref="BeanInjector")
			.asSingleton()
			.asEagerInit();
		map("CodexDatasource").toFactoryMethod(factory="ColdBoxFactory",method="getDatasource")
			.methodArg(name="alias",value="codex")
			.asSingleton();
		map("anonBean:5E46D4E73B").toFactoryMethod(factory="TransferConfigFactory",method="getTransferConfig")
			.methodArg(name="configPath",value="${Transfer_configPath}")
			.methodArg(name="definitionPath",value="${Transfer_definitionPath}")
			.methodArg(name="dsnBean",ref="CodexDatasource")
			.asSingleton();
		map("TransferFactory").to("transfer.TransferFactory")
			.initArg(name="configuration",ref="anonBean:5E46D4E73B")
			.asSingleton();
		map("Transfer").toFactoryMethod(factory="TransferFactory",method="getTransfer")
			.asSingleton();
		map("Datasource").toFactoryMethod(factory="TransferFactory",method="getDatasource")
			.asSingleton();
		map("Transaction").toFactoryMethod(factory="TransferFactory",method="getTransaction")
			.asSingleton();
		map("BeanPopulator").to("codex.model.transfer.BeanPopulator")
			.asSingleton();
		map("JavaLoader").to("codex.model.util.JavaLoader")
			.asSingleton()
			.asEagerInit();
		map("WikiService").to("codex.model.wiki.WikiService")
			.asSingleton();
		map("HTML2WikiConverter").to("codex.model.wiki.HTML2WikiConverter")
			.asSingleton();
		map("CommentsService").to("codex.model.comments.CommentsService")
			.asSingleton();
		map("ConfigService").to("codex.model.wiki.ConfigService")
			.asSingleton();
		map("SearchFactory").to("codex.model.search.SearchFactory")
			.asSingleton();
		map("SearchEngine").toFactoryMethod(factory="SearchFactory",method="getSearchEngine")
			.asSingleton();
		map("WikiText").to("codex.model.wiki.parser.WikiText")
			.asSingleton();
		map("WikiPlugins").to("codex.model.wiki.parser.WikiPlugins");
		map("Feed").to("codex.model.wiki.parser.Feed")
			.asSingleton();
		map("MessageBox").to("codex.model.wiki.parser.MessageBox")
			.asSingleton();
		map("RSSManager").to("codex.model.rss.RSSManager")
			.asSingleton();
		map("DataManager").to("codex.model.data.DataManager")
			.asSingleton();
		map("SecurityService").to("codex.model.security.SecurityService")
			.setter(name="sessionstorage",ref="sessionstorage")
			.asSingleton();
		map("UserService").to("codex.model.security.UserService")
			.asSingleton();
		map("LookupService").to("codex.model.lookups.LookupService")
			.asSingleton();

	}	
</cfscript>
</cfcomponent>