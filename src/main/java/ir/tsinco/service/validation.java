package ir.tsinco.service;

public class validation {


    public static int parsInt(String args) {

        int parsValue = -1;

        try {
            parsValue = Integer.parseInt(args);
        } catch (NumberFormatException e) {

        }

        return parsValue;
    }


    public static int parsInt(String args, int defaultValue) {

        int parsValue = defaultValue;

        try {
            parsValue = Integer.parseInt(args);
        } catch (NumberFormatException e) {


        }

        return parsValue;
    }

    public static long parsLong(String args) {

        long parsValue =  -1;

        try {
            parsValue = Long.parseLong(args);
        } catch (NumberFormatException e) {


        }

        return parsValue;
    }
}
