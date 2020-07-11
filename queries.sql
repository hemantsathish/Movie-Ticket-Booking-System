-- Query #1 = For telling which movies require parental guidance based on their genres 

select m.name as requires_parental_guidance
from movie m
where m.genre='Fantasy/Scifi' or m.genre='Drama/Comedy' or m.genre='Romance/Comedy'
or m.genre='Horror' ;

-- Query #2 = For getting the details of the people who booked more than 10 tickets 

Select First_Name, Last_Name from Web_User 
where Web_User_ID IN 
(Select distinct User_ID from Booking where No_of_Tickets > 10)

-- Query #3 = Getting the details of the user wrt the card number used in the payment process

Select First_name, Last_name, Email_ID, Phone_number, Card_number 
from Web_user as wu
Inner Join Booking as b
On wu.Web_User_ID = b.User_ID

-- Query #4 = To get the total earnings per movie and arrange them in a descending order.

Select Name, Total_Revenue
from (Select Movie_ID, sum(Total_cost) as Total_Revenue
from Show as s
Inner Join Booking as b
On s.Show_ID = b.Show_ID
group by Movie_ID) as m
Inner Join Movie
On m.Movie_ID = Movie.Movie_ID
Order By Total_Revenue DESC

-- Query #5 = To get the details of the Theatre (name and location) based on the screen ID.

SELECT Name_of_Theatre, Area, Screen_ID
FROM Theatre as t
Left JOIN Screen as s
On t.Theatre_ID = s.Theatre_ID

-- Query #6 = To get the card details of the user wrt his/her ticket ID

SELECT Name_On_Card, Card_Number, Total_Cost, Ticket_ID
FROM Booking as b
FULL OUTER JOIN Ticket as t
ON b.Booking_ID = t.Booking_ID
