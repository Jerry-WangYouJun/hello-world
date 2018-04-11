package com.saki.utils;

public class SystemUtil {
    public  static String  getSystemName(){
    	String osName =  System.getProperty("os.name");
    	if(osName.toUpperCase().startsWith("MAC")) {
    		return "mac";
    	}else{
    		return"win";
    	}
    }
}  
