/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

package com.headbangers.epsilon.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {

    static SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    static SimpleDateFormat sdfSQL = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public static String format(Date date) {
        return sdf.format(date);
    }

    public String formatDateForSQL(Date date) {
        return sdfSQL.format(date);
    }

    public Date parseFromView(String string) {
        try {
            return sdf.parse(string);
        } catch (ParseException ex) {
            return getTodayMorning();
        }
    }

    public Date addMonthToDate(Date date, int nb) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, nb);
        return calendar.getTime();
    }

    public Date getDateAtMorning (Date date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    public Date getTodayMorning() {
        return getDateAtMorning(new Date());
    }

    public Date getDateAtEvening(Date date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        return calendar.getTime();
    }

    public Date getTodayEvening() {
        return getDateAtEvening(new Date());
    }

    public Date getTodayPlusOneMonth() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, 1);
        return calendar.getTime();
    }

    public Date getDatePlusOneMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, 1);
        return calendar.getTime();
    }

    public Date getDateMinusOneMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, -1);
        return calendar.getTime();
    }

    public Date getFirstDayOfTheMonth() {
        return getFirstDayOfTheMonth(null);
    }

    public Date getFirstDayOfTheYear() {
        return getFirstDayOfTheMonth(1);
    }

    public Date getFirstDayOfTheMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date != null ? date : getTodayMorning());
        calendar.set(Calendar.DAY_OF_MONTH, 1);

        return calendar.getTime();
    }

    public Date getFirstDayOfTheMonth(int monthInt) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, monthInt);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);

        return calendar.getTime();
    }

    public Date getLastDayOfTheMonth() {
        return getLastDayOfTheMonth(null);
    }

    public Date getLastDayOfTheMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date != null ? date : getTodayMorning());
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        return calendar.getTime();
    }

    public Date getLastDayOfTheMonth(int month) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, month);
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        return calendar.getTime();
    }

    public Integer getMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date != null ? date : getTodayMorning());
        return calendar.get(Calendar.MONTH);
    }

    public Integer getYear(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date != null ? date : getTodayMorning());
        return calendar.get(Calendar.YEAR);
    }

    public Integer getCurrentYear() {
        Calendar calendar = Calendar.getInstance();
        return calendar.get(Calendar.YEAR);
    }

    public Integer getSixMonthAgo(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date != null ? date : getTodayMorning());
        calendar.roll(Calendar.MONTH, -6);
        return calendar.get(Calendar.MONTH);
    }

    public Date firstDayOfYear(int year) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, year);
        calendar.set(Calendar.MONTH, Calendar.JANUARY);
        return getFirstDayOfTheMonth(calendar.getTime());
    }

    public Date lastDayOfYear(int year) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, year);
        calendar.set(Calendar.MONTH, Calendar.DECEMBER);
        return getLastDayOfTheMonth(calendar.getTime());
    }
}
