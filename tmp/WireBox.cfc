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
			.asSingleton()
			.noAutowire();
		map("InterceptorService").toFactoryMethod(factory="ColdBoxController",method="getinterceptorService")
			.asSingleton()
			.noAutowire();
		map("ConfigBean").toFactoryMethod(factory="ColdBoxFactory",method="getConfigBean")
			.asSingleton()
			.noAutowire();
		map("ColdboxOCM").toFactoryMethod(factory="ColdboxFactory",method="getColdBoxOCM")
			.asSingleton()
			.noAutowire();
		map("BeanInjector").toFactoryMethod(factory="ColdBoxFactory",method="getPlugin")
			.methodArg(name="plugin",value="beanFactory")
			.asSingleton()
			.noAutowire();
		map("sessionstorage").toFactoryMethod(factory="ColdboxFactory",method="getPlugin")
			.methodArg(name="plugin",value="sessionstorage")
			.asSingleton()
			.noAutowire();
		map("TransferConfigFactory").to("coldbox.system.extras.transfer.TransferConfigFactory")
			.asSingleton()
			.noAutowire();
		map("TDOBeanInjectorObserver").to("coldbox.system.extras.transfer.TDOBeanInjectorObserver")
			.initArg(name="Transfer",ref="Transfer")
			.initArg(name="ColdBoxBeanFactory",ref="BeanInjector")
			.asSingleton()
			.noAutowire()
			.asEagerInit();
		map("CodexDatasource").toFactoryMethod(factory="ColdBoxFactory",method="getDatasource")
			.methodArg(name="alias",value="codex")
			.asSingleton()
			.noAutowire();
		map("anonBean:E8E7CE0427").toFactoryMethod(factory="TransferConfigFactory",method="getTransferConfig")
			.methodArg(name="configPath",value="${Transfer_configPath}")
			.methodArg(name="definitionPath",value="${Transfer_definitionPath}")
			.methodArg(name="dsnBean",ref="CodexDatasource")
			.asSingleton()
			.noAutowire();
		map("TransferFactory").to("transfer.TransferFactory")
			.initArg(name="configuration",ref="anonBean:E8E7CE0427")
			.asSingleton()
			.noAutowire();
		map("Transfer").toFactoryMethod(factory="TransferFactory",method="getTransfer")
			.asSingleton()
			.noAutowire();
		map("Datasource").toFactoryMethod(factory="TransferFactory",method="getDatasource")
			.asSingleton()
			.noAutowire();
		map("Transaction").toFactoryMethod(factory="TransferFactory",method="getTransaction")
			.asSingleton()
			.noAutowire();
		map("BeanPopulator").to("codex.model.transfer.BeanPopulator")
			.asSingleton()
			.noAutowire();
		map("JavaLoader").to("codex.model.util.JavaLoader")
			.asSingleton()
			.noAutowire()
			.asEagerInit();
		map("WikiService").to("codex.model.wiki.WikiService")
			.asSingleton()
			.noAutowire();
		map("HTML2WikiConverter").to("codex.model.wiki.HTML2WikiConverter")
			.asSingleton()
			.noAutowire();
		map("CommentsService").to("codex.model.comments.CommentsService")
			.asSingleton()
			.noAutowire();
		map("ConfigService").to("codex.model.wiki.ConfigService")
			.asSingleton()
			.noAutowire();
		map("SearchFactory").to("codex.model.search.SearchFactory")
			.asSingleton()
			.noAutowire();
		map("SearchEngine").toFactoryMethod(factory="SearchFactory",method="getSearchEngine")
			.asSingleton()
			.noAutowire();
		map("WikiText").to("codex.model.wiki.parser.WikiText")
			.asSingleton()
			.noAutowire();
		map("WikiPlugins").to("codex.model.wiki.parser.WikiPlugins")
			.noAutowire();
		map("Feed").to("codex.model.wiki.parser.Feed")
			.asSingleton()
			.noAutowire();
		map("MessageBox").to("codex.model.wiki.parser.MessageBox")
			.asSingleton()
			.noAutowire();
		map("RSSManager").to("codex.model.rss.RSSManager")
			.asSingleton()
			.noAutowire();
		map("DataManager").to("codex.model.data.DataManager")
			.asSingleton()
			.noAutowire();
		map("SecurityService").to("codex.model.security.SecurityService")
			.setter(name="sessionstorage",ref="sessionstorage")
			.asSingleton()
			.noAutowire();
		map("UserService").to("codex.model.security.UserService")
			.asSingleton()
			.noAutowire();
		map("LookupService").to("codex.model.lookups.LookupService")
			.asSingleton()
			.noAutowire();

	}	
</cfscript>
</cfcomponent>