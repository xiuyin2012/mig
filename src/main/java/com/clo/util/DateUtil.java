package com.clo.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {

	/****
	 * 传入具体日期 ，返回具体日期减一个月。
	 * 
	 * @param date
	 *            日期(2015-06-03)
	 * @return 2015-06-03
	 * @throws ParseException
	 */
	public static String changeMonth(String date, int diffMon, String oper)
			throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date dt = sdf.parse(date);
		Calendar rightNow = Calendar.getInstance();
		rightNow.setTime(dt);

		if ("+".equals(oper)) {
			rightNow.add(Calendar.MONTH, diffMon);
		}
		if ("-".equals(oper)) {
			rightNow.add(Calendar.MONTH, -diffMon);
		}
		Date dt1 = rightNow.getTime();
		String reStr = sdf.format(dt1);

		return reStr;
	}
}
