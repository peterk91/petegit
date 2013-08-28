/*
Name: Peter Krepa
username: copk2
Student Number: A913724
*/

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.text.DecimalFormat;

public class usefulmethods
	{
    
	public static String getPrice(int p, int q, String r, String s)
		{
		String priceString = "";
		final int stationamnt = 5;
		double[] prices ={0,60,55,75,55,50,0,5,25,10,55,5,0,18,8,70,20,18,0,20,60,10,7,19,0};
		double [][] pricetable = new double [5][5];
		int a = 0;
		for(int i=0;i<stationamnt;i++)
			{
			for(int x=0;x<stationamnt;x++)
				{
				pricetable[i][x] = prices[a];
				a = a+1;
				}
			}
		//has put all the prices from the array into a 2d array
		DecimalFormat df = new DecimalFormat("0.00");
		//the decimal format is changed as it is currency.
		double price = pricetable[p][q];
		if (	((s.equals("31"))&&(r.equals("January")||r.equals("March")||r.equals("May")||r.equals("July")||r.equals("August")||r.equals("October")||r.equals("December")))||((s.equals("30"))&&(r.equals("April")||r.equals("June")||r.equals("September")||r.equals("November")))||((s.equals("28"))&&(r.equals("February"))))
			{
			price = price*1.1;
			priceString = "Your journey will cost £"+df.format(price)+". This price is 10% higher as you are travelling on the last day of the month.";
			}
		//depending on when they are travelling the price varies
		else
			{
			priceString = "Your journey will cost £"+df.format(price);
			}
		return priceString;
		}

	public static String getTime(int p, int q) 
		{
		String timeString = "";
		final int stationamnt = 5;
		int[] times ={0,90,110,210,100,90,0,10,60,25,100,10,0,57,16,200,60,56,0,59,110,20,15,59,0};
		int [][] timetable = new int [5][5];
		int a = 0;
		for(int i=0;i<stationamnt;i++)
			{
			for(int x=0;x<stationamnt;x++)
				{
				timetable[i][x] = times[a];
				a = a+1;
				}
			}
		//it takes the times and builds a 2d array
		int mins = timetable[p][q];
		final int minsHour = 60;
		if(mins>=60){
					int hour = mins/minsHour;
					int minutes = mins%minsHour;
					if(hour==1){timeString = "Your journey will take "+hour+" hour and "+minutes+" minutes";}
					if(hour>1){timeString = "Your journey will take "+hour+" hours and "+minutes+" minutes";}
					}
		if(mins<60){timeString = "Your journey will take "+mins+" minutes";}	
		return timeString;
		}
		
	public static int getStationNo(String p)
		{
		int sta = 0;
		if(p.equals("London")) {sta=0;}
		if(p.equals("Loughborough")) {sta=1;}
		if(p.equals("Nottingham")) {sta=2;}
		if(p.equals("Middlesbourgh")) {sta=3;}
		if(p.equals("Derby")) {sta=4;}
		return sta;
		}
	
	public static Object[] getPossibleDays(String p)
		{
		//it uses the month chosen to return the days of that month
		final Object[] thirtyOne = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
		final Object[] thirty = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30};
		final Object[] feb = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28};
		Object[] selected = {};
		if(p.equals("January")||p.equals("March")||p.equals("May")||p.equals("July")||p.equals("August")||p.equals("October")||p.equals("December")){selected = thirtyOne;}
		if(p.equals("April")||p.equals("June")||p.equals("September")||p.equals("November")){selected = thirty;}
		if(p.equals("February")){selected = feb;}
		return selected;
		}
		
		public static Object[] getPossibleStations(String p)
		{
		//it takes the chosen station and returns an array without that station listed
		final Object[] lon = {"Loughborough", "Nottingham", "Middlesbourgh", "Derby"};
		final Object[] luf = { "London", "Nottingham", "Middlesbourgh", "Derby" };
		final Object[] notts = { "London", "Loughborough", "Middlesbourgh", "Derby"};
		final Object[] midd = { "London", "Loughborough", "Nottingham", "Derby"};
		final Object[] der = { "London", "Loughborough", "Nottingham", "Middlesbourgh"};
		
		Object[] selected = {};
		if(p.equals("London")){selected = lon;}
		if(p.equals("Loughborough")){selected = luf;}
		if(p.equals("Nottingham")){selected = notts;}
		if(p.equals("Middlesbourgh")){selected = midd;}
		if(p.equals("Derby")){selected = der;}
		return selected;
		}
	
	}