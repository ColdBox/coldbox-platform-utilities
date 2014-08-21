<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE beans SYSTEM "http://www.springframework.org/dtd/spring-beans.dtd">
<beans default-autowire="byName">

	<bean id="UserManager" class="common.ourdomain.security.UserManager">
	</bean>

	<bean id="UserManager" class="common.ourdomain.security.UserManager">
        <constructor-arg name="productionDSN"><bean factory-bean="EnvironmentService" factory-method="getProductionDSN" /></constructor-arg>
        <constructor-arg name="PaymentService"><ref bean="PaymentService" /></constructor-arg>
    </bean>

</beans>