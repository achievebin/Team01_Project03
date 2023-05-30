package utils;

import java.text.DecimalFormat;

public class FormatUtil {
	  public static String addComma(String price) {
	    try {
	      int num = Integer.parseInt(price);
	      DecimalFormat decimalFormat = new DecimalFormat("#,###");
	      return decimalFormat.format(num);
	    } catch (NumberFormatException e) {
	      return price;
	    }
	  }
	}
