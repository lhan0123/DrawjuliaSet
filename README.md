# Project Description
This project aims to draw a Julia Set image using ARM assembly language. The program consists of several functions that perform various tasks, including storing and printing group member information, calculating and managing IDs, and drawing the Julia Set graph.   ![image](https://github.com/lhan0123/CYCU-Assembly-DrawjuliaSet/blob/main/images/result.JPG)

## Functions:
NAME Function:
The NAME function is responsible for storing and printing the group name and the English names of the group members. It initializes four memory addresses with the corresponding group and member names and then prints them. Finally, it returns the member names and the group to main.c.

## ID Function:
The ID function reads and stores the IDs of the group members into specified memory locations. It also calculates the sum of the IDs. Once all three IDs are entered, if the input command is 'p', the function retrieves and outputs the stored IDs and their sum. Otherwise, it displays an error message. Finally, it returns the group member IDs and the total sum to main.c.

## DrawJuliaSet Function:
The DrawJuliaSet function is responsible for generating and storing the color values for each point in the Julia Set graph. It calculates the color values for various complex points on the graph and stores them in specified memory locations. These values will be later retrieved and used to display the colors of each point on the graph when the program returns to main.c.

## Main Function:
The main function acts as the entry point of the program. It calls the NAME and ID functions to print the group member names and IDs. It then combines the returned values from these functions and displays the corresponding group member IDs, English names, and the sum of the IDs. After that, it calls the DrawJuliaSet function to draw and display the Julia Set graph. Finally, it repeats the display of the group member IDs and English names.
