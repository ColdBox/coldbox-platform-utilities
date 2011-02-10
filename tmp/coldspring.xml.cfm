<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE beans SYSTEM "http://www.springframework.org/dtd/spring-beans.dtd">
<beans default-autowire="byName">
	
	<!-- ColdBox Related Beans -->
	<bean id="ColdboxFactory" class="coldbox.system.extras.ColdboxFactory" autowire="no" />
	<bean id="ColdBoxController" 	factory-bean="ColdBoxFactory" 		factory-method="getColdBox" />
	<bean id="InterceptorService" 	factory-bean="ColdBoxController" 	factory-method="getinterceptorService" />
	<bean id="ConfigBean" 			factory-bean="ColdBoxFactory" 		factory-method="getConfigBean" />
	<bean id="ColdboxOCM" 			factory-bean="ColdboxFactory" 		factory-method="getColdBoxOCM" />
	<bean id="BeanInjector" 		factory-bean="ColdBoxFactory" 		factory-method="getPlugin">
   		<constructor-arg name="plugin"><value>beanFactory</value></constructor-arg>	
   	</bean>
   	<bean id="sessionstorage" 		factory-bean="ColdboxFactory" factory-method="getPlugin">
		<constructor-arg name="plugin"><value>sessionstorage</value></constructor-arg>
	</bean>
	<!-- Coldbox-transfer Config Factory -->
	<bean id="TransferConfigFactory" class="coldbox.system.extras.transfer.TransferConfigFactory" singleton="true" />
	<!-- coldbox-transfer observer for decorator injections -->
   	<bean id="TDOBeanInjectorObserver" class="coldbox.system.extras.transfer.TDOBeanInjectorObserver" lazy-init="false">
   		<constructor-arg name="Transfer"><ref bean="Transfer"></ref></constructor-arg>
   		<constructor-arg name="ColdBoxBeanFactory"><ref bean="BeanInjector"></ref></constructor-arg>
   	</bean>
   	<bean id="CodexDatasource" factory-bean="ColdBoxFactory" factory-method="getDatasource">
		<constructor-arg name="alias"><value>codex</value></constructor-arg>
	</bean>
		   	
   	<!-- transfer -->
	<bean id="TransferFactory" class="transfer.TransferFactory" singleton="true">
	   <constructor-arg name="configuration">
	      <bean factory-bean="TransferConfigFactory" factory-method="getTransferConfig">
	         <!-- Config Path -->
	         <constructor-arg name="configPath"><value>${Transfer_configPath}</value></constructor-arg>
	         <!-- Definitions Path -->
	         <constructor-arg name="definitionPath"><value>${Transfer_definitionPath}</value></constructor-arg>
	         <!-- ColdBox Datasource Bean -->
	         <constructor-arg name="dsnBean"><ref bean="CodexDatasource" /></constructor-arg>
	      </bean>
	   </constructor-arg>
	</bean>
	
	<!-- Transfer related beans -->
	<bean id="Transfer" factory-bean="TransferFactory" factory-method="getTransfer" />
	<bean id="Datasource" factory-bean="TransferFactory" factory-method="getDatasource" />
	<bean id="Transaction" factory-bean="TransferFactory" factory-method="getTransaction" />
	<bean id="BeanPopulator" class="codex.model.transfer.BeanPopulator"/>
	
	<!-- JavaLoader: Started at bootup. -->
	<bean id="JavaLoader" class="codex.model.util.JavaLoader" lazy-init="false" />
	
	<!-- wiki -->
	<bean id="WikiService" class="codex.model.wiki.WikiService" />
	<bean id="HTML2WikiConverter" class="codex.model.wiki.HTML2WikiConverter" />
	<bean id="CommentsService" class="codex.model.comments.CommentsService" />
	<!-- Config -->
	<bean id="ConfigService" class="codex.model.wiki.ConfigService" />
	<!--  Search Factory -->
	<bean id="SearchFactory" class="codex.model.search.SearchFactory" />
	<bean id="SearchEngine" factory-bean="SearchFactory" factory-method="getSearchEngine" />	
	<!-- Parsers -->
	<bean id="WikiText" class="codex.model.wiki.parser.WikiText" />
	<bean id="WikiPlugins" class="codex.model.wiki.parser.WikiPlugins" singleton="false" />
	<bean id="Feed" class="codex.model.wiki.parser.Feed" />
	<bean id="MessageBox" class="codex.model.wiki.parser.MessageBox" />
	<!-- rss -->
	<bean id="RSSManager" class="codex.model.rss.RSSManager" />
	<!-- Import/Exporters -->
	<bean id="DataManager" class="codex.model.data.DataManager" />
	<!-- Security -->
	<bean id="SecurityService" class="codex.model.security.SecurityService">
		<property name="sessionstorage">
			<ref bean="sessionstorage"/>
		</property>
		<!--User service autowired-->
	</bean>
	<bean id="UserService" class="codex.model.security.UserService" />
	
	<!-- Lookups -->
	<bean id="LookupService" class="codex.model.lookups.LookupService" />
	
</beans>