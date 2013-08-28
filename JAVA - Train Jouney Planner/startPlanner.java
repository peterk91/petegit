/*
Name: Peter Krepa
username: copk2
Student Number: A913724
*/

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;

class startPlanner
{
    public static void main(String[] args)
	{
	
	//setting up the JFrame
	JFrame mainFrame;	
	mainFrame = new JFrame();
	mainFrame.setVisible(true);
	mainFrame.setSize(340, 110);
	mainFrame.setTitle("Train Route Planner");
	mainFrame.setLocationRelativeTo(null);
	mainFrame.setResizable(false);
	mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	JPanel mainPanel = new JPanel( );
	mainPanel.setLayout(new FlowLayout());
	
	//creating and adding the buttons
	final JButton priceButton = new JButton("Price");	
	final JButton timeButton = new JButton("Time");
	final JButton routeButton = new JButton("Route");
	final JButton adminButton = new JButton("Admin");
	adminButton.setForeground(Color.RED);
	final JButton endButton = new JButton("Exit");
	endButton.setForeground(Color.BLUE);
	mainPanel.add(priceButton);
	mainPanel.add(timeButton);
	mainPanel.add(routeButton);
	mainPanel.add(adminButton);
	mainPanel.add(endButton);
	mainFrame.add(mainPanel);
	
	//when the program starts it creates an array of the routes of all the trains, as default it says it is a direct route
	final Route [][] routetable = new Route[5][5];
	for(int b=0;b<5;b++)
		{
		for(int c=0;c<5;c++)
			{
			Route travelInfo = new Route();
			routetable[b][c] = travelInfo;
			}
		}	
	
//class pressed is what is run when a button is pressed
	class pressed implements ActionListener 
		{
    	public void actionPerformed(ActionEvent event)
			{		
			Object station1, station2; //initalised here as is used when any button is clicked, apart from End
			Object[] stations = { "London", "Loughborough", "Nottingham", "Middlesbourgh", "Derby" };
		
       		JButton clickedButton = (JButton) event.getSource();
        	String buttonText = clickedButton.getText();
			
			if (clickedButton==endButton) 	{System.exit(0);}
			
			if (clickedButton==priceButton)	{
											station1 = JOptionPane.showInputDialog(null,"What station are you starting at?", "Price",JOptionPane.QUESTION_MESSAGE, null, stations, stations[0]);
											
											Object[] remainingStations = {};
											remainingStations= usefulmethods.getPossibleStations(station1.toString()); //this gets an array of all the stations, not including the initially selected one. This stops the user choosing the same station twice.
											station2 = JOptionPane.showInputDialog(null,"What station going to?", "Price",JOptionPane.QUESTION_MESSAGE, null, remainingStations, remainingStations[0]);
											
											Object day, month;
											Object[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
											month = JOptionPane.showInputDialog(null,"In which month do you with to travel?", "Price",JOptionPane.QUESTION_MESSAGE, null,months, months[0]);
											Object[] days = {};
											days = usefulmethods.getPossibleDays(month.toString());	//this gets an array for the days that are in the month selected, so the user cannot make a mistake eg. choosing the 31st of Feb
											day = JOptionPane.showInputDialog(null,"What day are you travelling?", "Price",JOptionPane.QUESTION_MESSAGE, null, days, days[0]);
											int sta1 = usefulmethods.getStationNo(station1.toString());	//this get the station number accosiated with the station chosen
											int sta2 = usefulmethods.getStationNo(station2.toString());
											JOptionPane.showMessageDialog(null, usefulmethods.getPrice(sta1,sta2, month.toString(), day.toString()), "Price", JOptionPane.INFORMATION_MESSAGE); //this calls the getPrice method using the station number and date variables
											}
											
			if (clickedButton==timeButton)	{
											//same idea as getPrice but no date is involved
											station1 = JOptionPane.showInputDialog(null,"What station are you starting at?", "Time",JOptionPane.QUESTION_MESSAGE, null,stations, stations[0]);
											Object[] remainingStations = {};
											remainingStations= usefulmethods.getPossibleStations(station1.toString());
											station2 = JOptionPane.showInputDialog(null,"What station going to?", "Time",JOptionPane.QUESTION_MESSAGE, null, remainingStations, remainingStations[0]);
											int sta1 = usefulmethods.getStationNo(station1.toString());
											int sta2 = usefulmethods.getStationNo(station2.toString());
											JOptionPane.showMessageDialog(null, usefulmethods.getTime(sta1,sta2), "Time", JOptionPane.INFORMATION_MESSAGE);
											}
											
			if (clickedButton==routeButton)	{
											//same idea as getTime but it doesnt call a method to get the result, it accesses the global array made earlier, routetable.
											station1 = JOptionPane.showInputDialog(null,"What station are you starting at?", "Route",JOptionPane.QUESTION_MESSAGE, null,stations, stations[0]);
											Object[] remainingStations = {};
											remainingStations= usefulmethods.getPossibleStations(station1.toString());
											station2 = JOptionPane.showInputDialog(null,"What station going to?", "Route",JOptionPane.QUESTION_MESSAGE, null, remainingStations, remainingStations[0]);
											int number1 = usefulmethods.getStationNo(station1.toString());
											int number2 = usefulmethods.getStationNo(station2.toString());
											routetable[number1][number2].getRoute();
											}
											
			if (clickedButton==adminButton)	{
											Object[] adminOptions = { "Input Route", "Save Route", "Retrieve Route"};
											Object choice = JOptionPane.showInputDialog(null,"What would you like to do?", "Admin",JOptionPane.QUESTION_MESSAGE, null,adminOptions, adminOptions[0]);
											if (choice==adminOptions[0])	{
																			//this asks the user choose a route, and then uses these variables to call the setRoute method
																			station1 = JOptionPane.showInputDialog(null,"What station are you starting at?", "Route",JOptionPane.QUESTION_MESSAGE, null,stations, stations[0]);
																			Object[] remainingStations = {};
																			remainingStations= usefulmethods.getPossibleStations(station1.toString());
																			station2 = JOptionPane.showInputDialog(null,"What station going to?", "Route",JOptionPane.QUESTION_MESSAGE, null, remainingStations, remainingStations[0]);
																			int number1 = usefulmethods.getStationNo(station1.toString());
																			int number2 = usefulmethods.getStationNo(station2.toString());
																			Route travel = new Route();
																			travel.setRoute();
																			routetable[number1][number2] = travel;
																			}
											if (choice==adminOptions[1]) 	{
																			//this saves the global array routetable, which holds the information on all the routes
																			try
																				{
																				JFileChooser chooser = new JFileChooser( );
																				chooser.showSaveDialog(null);
																				File outFile  = chooser.getSelectedFile();
																				FileOutputStream  outFileStream  = new FileOutputStream(outFile);
																				ObjectOutputStream out = new ObjectOutputStream(outFileStream);
																				out.writeObject(routetable);
																				out.close();
																				}
																			catch(IOException e){}
											
																			}
											if (choice==adminOptions[2]) 	{
																			//this opens up a selected file and replaces the global array routetable, with all the information in the file
																			try
																				{
																				JFileChooser chooser = new JFileChooser( );
																				chooser.showOpenDialog(null);
																				File inFile  = chooser.getSelectedFile();
																				FileInputStream inFileStream = new FileInputStream(inFile);
																				ObjectInputStream in = new ObjectInputStream(inFileStream);
																				Route [][] temp = (Route[][]) in.readObject();
																				for(int b=0;b<5;b++)
																					{
																					for(int c=0;c<5;c++)
																						{
																						routetable[b][c] = temp[b][c];
																						}
																					}
																				}
																			catch(IOException e){}
																			catch (ClassNotFoundException e) {}
																			}
											
											}	
			}
		}
	
	//adding the actionlistener to each button
	pressed buttonPress = new pressed( );
	priceButton.addActionListener(buttonPress);
	timeButton.addActionListener(buttonPress);
	routeButton.addActionListener(buttonPress);
	adminButton.addActionListener(buttonPress);
	endButton.addActionListener(buttonPress);

	}
}


