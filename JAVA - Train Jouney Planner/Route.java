/*
Name: Peter Krepa
username: copk2
Student Number: A913724
*/

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;

class Route implements Serializable  {

	Object[] numbers = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};
    private String listRoute;
	Object choice2;

	public Route()	{
					listRoute = "You train is on a direct route or no route has been entered by the administrator";
					}
    
    public void getRoute()	{
							JOptionPane.showMessageDialog(null, listRoute, "Route", JOptionPane.INFORMATION_MESSAGE);
							}

    public void setRoute()	{
							//asks the user how many stations they want to add
							listRoute = "Your train will stop at ";
							Object[] routeArray;
							Object temp;
							Object choice2 = JOptionPane.showInputDialog(null,"How many stations do you want to enter?", "Admin",JOptionPane.QUESTION_MESSAGE, null,numbers, numbers[0]);
							int count = 0;
							int numChoice =1;
							
							//changes their answer into an int
							while ( choice2 != numbers[count]  )	
								{
								numChoice   =  count + 2;
								count = count + 1;
								}
							//asks them to type in each stop
							routeArray = new Object[numChoice];
							for(int i=0;i<numChoice;i++)	
								{
								temp = JOptionPane.showInputDialog("Please enter stop "+(i+1));
								routeArray[i] = temp;
								}
							//it then produces a string which names all the stops on the route
							if(routeArray.length>1)
								{
								String temp2;
								for(int x=0; x<routeArray.length-2;x++)
									{
									temp2 = routeArray[x].toString();
									listRoute = listRoute+temp2+", ";
									}
								listRoute = listRoute + routeArray[routeArray.length-2] +" and " + routeArray[routeArray.length-1] +".";
								}
							else
								{
								listRoute = listRoute + routeArray[0].toString();
								}
								
							}    
}
