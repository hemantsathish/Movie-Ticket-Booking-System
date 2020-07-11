CREATE Table Web_user(
Web_User_ID varchar(5),
First_Name varchar(15), 
Last_Name varchar(20),
Email_ID varchar(30),
Age int,
Phone_Number varchar(10) NOT NULL, 
Primary Key(Web_User_ID));

Create Table Theatre(
Theatre_ID varchar(5),
Name_of_Theatre varchar(30) NOT NULL,
No_of_Screens int,
Area varchar(30),
Primary Key(Theatre_ID));

CREATE TABLE Screen(
Screen_ID varchar(5),
No_of_Seats_Gold int NOT NULL,
No_of_Seats_Silver int NOT NULL,
Theatre_ID varchar(5),
Primary Key(Screen_ID),
Foreign Key(Theatre_ID) REFERENCES Theatre(Theatre_ID) ON DELETE CASCADE ON UPDATE CASCADE);

Create Table Movie(
Movie_ID varchar(5),
Name varchar(30) NOT NULL,
Language varchar(10),
Genre varchar(20),
Target_Audience varchar(5),
Primary Key(Movie_ID));

CREATE Table Show(				
Show_ID varchar(10),
Show_Time time NOT NULL,
Show_Date date NOT NULL,				
Seats_Remaining_Gold int NOT NULL CHECK (Seats_Remaining_Gold >= 0),
Seats_Remaining_Silver int NOT NULL CHECK (Seats_Remaining_Silver >= 0),
Class_Cost_Gold int NOT NULL,
Class_Cost_Silver int NOT NULL,
Screen_ID varchar(5) NOT NULL,
Movie_ID varchar(5) NOT NULL,
Primary Key(Show_ID),
Foreign Key (Screen_ID) REFERENCES Screen(Screen_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Foreign Key (Movie_ID) REFERENCES Movie(Movie_ID) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE Table Booking(
Booking_ID varchar(10),
No_of_Tickets int NOT NULL,
Total_Cost int NOT NULL,                                           
Card_Number varchar(19),
Name_on_card varchar(21),
User_ID varchar(5),
Show_ID varchar(10),
Foreign Key (User_ID) REFERENCES Web_User (Web_User_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Foreign Key (Show_ID) REFERENCES Show(Show_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Primary Key(Booking_ID));

CREATE Table Ticket(
Ticket_ID varchar(20),
Booking_ID varchar(10),
Class varchar(3) NOT NULL,
Price int NOT NULL,
Primary Key(Ticket_ID),
Foreign Key(Booking_ID) REFERENCES Booking(Booking_ID)ON DELETE CASCADE);
