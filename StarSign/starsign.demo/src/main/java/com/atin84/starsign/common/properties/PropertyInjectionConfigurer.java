package com.atin84.starsign.common.properties;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.TypeConverter;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.core.Ordered;
import org.springframework.core.PriorityOrdered;
import org.springframework.core.io.support.PropertiesLoaderSupport;
import org.springframework.util.ReflectionUtils;

public class PropertyInjectionConfigurer extends PropertiesLoaderSupport 
										 implements BeanPostProcessor, BeanFactoryAware, PriorityOrdered {

	private static final Logger log = LoggerFactory.getLogger(PropertyInjectionConfigurer.class);
    
    private ConfigurableListableBeanFactory beanFactory;
    private int order = Ordered.LOWEST_PRECEDENCE - 2;
    private Properties cachedProps = null;
    
    public void setBeanFactory(BeanFactory beanFactory) throws BeansException
    {
        if (!(beanFactory instanceof ConfigurableListableBeanFactory))
            throw new IllegalArgumentException("PropertyInjectionConfigurer requires a ConfigurableListableBeanFactory"); 
        
        this.beanFactory = (ConfigurableListableBeanFactory) beanFactory;
    }
    
    public void setOrder(int order)
    {
        this.order = order;
    }
    
    public int getOrder()
    {
        return this.order;
    }

    public Object postProcessBeforeInitialization(final Object bean,
            final String beanName) throws BeansException
    {   
        if (log.isTraceEnabled())
            log.trace("Run postProcessAfterInstantiation() for bean '"+ beanName + "'");
        
        setPropertyValueIntoFields(bean);
        invokePropertySettingMethods(bean);

        return bean;
    }
    
    private void setPropertyValueIntoFields(Object bean)
    {
        final Object target = bean;
        
        ReflectionUtils.doWithFields(bean.getClass(),
                                     new ReflectionUtils.FieldCallback() {
                                         public void doWith(Field field)
                                         {
                                             Property property = getAnnotation(field);
                                             if (property == null) return;
                                             checkValidField(field);
                                             setPropertyValueIntoField(target, field, property);
                                         }
                                     });
    }

    private void invokePropertySettingMethods(Object bean)
    {
        final Object target = bean;
        
        ReflectionUtils.doWithMethods(target.getClass(),
                                      new ReflectionUtils.MethodCallback() {
                                          public void doWith(Method method)
                                          {
                                              Property property = getAnnotation(method);
                                              if (property == null) return;
                                              checkValidMethod(method);
                                              invokePropertySettingMethod(target, method, property);
                                          }
                                      });
    }

    private Property getAnnotation(Method method)
    {
        return method.getAnnotation(Property.class);
    }
    
    private Property getAnnotation(Field field)
    {
        return field.getAnnotation(Property.class);
    }
    
    private void checkValidMethod(Method method)
    {
        if (Modifier.isStatic(method.getModifiers())) 
            throw new IllegalStateException("@Property annotation is not supported on static methods");
    }
    
    private void checkValidField(Field field)
    {
        if (Modifier.isStatic(field.getModifiers())) 
            throw new IllegalStateException("@Property annotation is not supported on static fields");
    }
    
    private void invokePropertySettingMethod(final Object target, Method method, Property property)
    {
        if (log.isDebugEnabled())
            log.debug("Inject property value via invoking method '" + method.getName() + "'");
        
        Class<?>[] types = method.getParameterTypes();        
        if (types.length != 1)  
            throw new IllegalStateException("@Property annotation requires one argument method : "+ method);
        
        Object value = getConfigValue(property, types[0]);
        if(value != null) 
        {
            ReflectionUtils.makeAccessible(method);
            ReflectionUtils.invokeMethod(method, target, new Object[] { value });
        }
    }
    
    private void setPropertyValueIntoField(final Object bean, Field field, Property property)
    {
        if (log.isDebugEnabled())
            log.debug("Inject property value into field '" + field.getName() + "'");
        
        Object value = getConfigValue(property, field.getType());
        if(value != null) 
        {
            ReflectionUtils.makeAccessible(field);
            ReflectionUtils.setField(field, bean, value);
        }
    }
    
    private Object getConfigValue(Property property, Class<?> type)
    {
        Object value = getProperties().get(property.name());        
        if(value == null) 
        {
            if(!property.required()) 
                return null;
            
            throw new IllegalArgumentException("Required property value is not found for key '"+property.name()+"'");
        }
        
        return convertValueType(value, type);
    }

    public Properties getProperties()
    {
        if (this.cachedProps == null)
        {
            try
            {
                this.cachedProps = mergeProperties();                
            }
            catch (IOException e)
            {
                throw new IllegalArgumentException(e);
            }
        }
        return this.cachedProps;
    }
    
    private Object convertValueType(Object value, Class<?> type)
    {
        TypeConverter typeConverter = this.beanFactory.getTypeConverter();
        return typeConverter.convertIfNecessary(value, type);
    }
    
    public Object postProcessAfterInitialization(Object bean, String beanName)
            throws BeansException
    {
        return bean;
    }
}
