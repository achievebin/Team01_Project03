package utils;

import java.text.DecimalFormat;

public class FormatUtil {
    public static String addComma(int price) {
        DecimalFormat decimalFormat = new DecimalFormat("#,###");
        return decimalFormat.format(price);
    }
}
