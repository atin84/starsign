package com.atin84.starsign.common.util;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

public class WebUtil {
	/**
	 * URI에서 요청 파일이름 추출
	 * @param uri
	 * @return
	 */
	public static String getURItoFileName(HttpServletRequest request) {
		String contextPath = request.getContextPath();
		String uri = request.getRequestURI();
		int begin = 0;
		if ((contextPath == null) || (contextPath.equals(""))) {
			begin = 1;
		} else {
			begin = contextPath.length() + 1;
		}
		
		int end;
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";");
		} else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?");
		} else {
			end = uri.length();
		}
		String fileName = uri.substring(begin, end);
		if (fileName.indexOf(".") != -1) {
			fileName = fileName.substring(0, fileName.lastIndexOf("."));
		}
		
		return fileName;
	}
	/**
	 * 케릭터 인코딩
	 * @param inp
	 * @return
	 */
	public static String unescape(String inp) {
       String rtnStr = new String();
       char [] arrInp = inp.toCharArray();
       int i;
       for(i=0;i<arrInp.length;i++) {
           if(arrInp[i] == '%') {
               String hex;
               if(arrInp[i+1] == 'u') {    //유니코드.
                   hex = inp.substring(i+2, i+6);
                    i += 5;
                } else {    //ascii
                    hex = inp.substring(i+1, i+3);
                    i += 2;
                }
                try{
                    rtnStr += new String(Character.toChars(Integer.parseInt(hex, 16)));
                } catch(NumberFormatException e) {
                    rtnStr += "%";
                    i -= (hex.length()>2 ? 5 : 2);
                }
            } else {
                rtnStr += arrInp[i];
            }
        }

        return rtnStr;
    }
	/**
	 * 문자열 인코딩
	 * @param str
	 * @return
	 */
	public static String getEnCodingString(String str) {
		try {
			str = new String(str.getBytes("8859_1"), "UTF-8");
		} 
		catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return str;
	}
}
