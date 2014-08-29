package com.atin84.starsign.common.properties;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 메서드나 필드에 스프링 외부에 정의된 프로퍼티 값을 읽어와 설정한다.
 * 
 * <p>
 * 빈을 Auto scan하여 PropertyPlaceholderConfigurer나 PropertyOverrideConfigurer를 사용할
 * 수 없는 경우에 사용한다.
 * @author semoria
 *
 */

@Retention(RetentionPolicy.RUNTIME)
@Target( { ElementType.METHOD, ElementType.FIELD })
public @interface Property
{
    String name();
    boolean required() default true;
}
