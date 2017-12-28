package com.clo.util;

public class CommonUtil {
	public static String[] splitByLastFlag(String str, String flag) {
		String[] rtnArray = new String[2];
		String[] arr = str.split(flag);
		String beforeStr = arr[0];

		String lastStr = arr[arr.length - 1];
		for (int i = 1; i < arr.length - 1; i++) {
			beforeStr += "_" + arr[i];
		}
		rtnArray[0] = beforeStr;
		rtnArray[1] = lastStr;
		return rtnArray;

	}
}
