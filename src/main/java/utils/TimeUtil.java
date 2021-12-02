package utils;

import java.text.ParseException;
import java.util.Date;

// 현재 쓰이지 않는 클래스
public class TimeUtil {

	/**
	 * 지정한 시간에서 현재까지 경과된 millisecond를 구한다.
	 * @param fromDate 지정한 시간
	 * @return 현재까지 경과된 millisecond
	 * @throws ParseException
	 */
	public static long getCurrentElapsedMillisecond(Date fromDate) throws ParseException {
		long result = 0;
		
		Date currentDate = new Date();
		
		result = currentDate.getTime() - fromDate.getTime();
		if (result < 0) {
			return 0;
		}
		
		return result;
	}
	
	/**
	 * 기간이 하루일 때의 남아있는 시간을 구한다.
	 * @param millisecond 경과된 millisecond
	 * @return 남아있는 시간이 "5일 12:05:30"과 같은 String으로 반환된다.
	 */
	public static String getRemainTimeInOneDay(long millisecond) {
//		long oneDayMillisecond = 24*60*60*1000;
		// TODO 테스트용 기간
		long oneDayMillisecond = 24*60*60*1000 + 18*60*60*1000;
		
		if (millisecond >= oneDayMillisecond) {
			return null;
		}
		long remainTime = oneDayMillisecond - millisecond;
		
		long day = remainTime/(1000*60*60*24);
		long hour = remainTime%(1000*60*60*24)/(1000*60*60);
		long minute = remainTime%(1000*60*60)/(1000*60);
		long second = remainTime%(1000*60)/(1000);
		
		String result = day + "일 "
						+ String.format("%02d", hour) + ":"
						+ String.format("%02d", minute) + ":"
						+ String.format("%02d", second);
		
		return result;
	}
}
