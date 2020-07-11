-- Trigger to update the new insert value in the ticket table wrt class added

CREATE TRIGGER update_seatsclass ON Ticket
after INSERT
not for REPLICATION
AS
BEGIN
select top 1 inserted.Class from inserted
end

-- Trigger to show the new user when inserted in the Web_user table

CREATE TRIGGER update_usernames ON Web_user
after INSERT
not for REPLICATION
AS
BEGIN
select top 1 inserted.First_Name from inserted
end

--Trigger to check for underage users

CREATE TRIGGER check_users_age ON Web_user
after INSERT
not for REPLICATION
AS
declare @user_age int
BEGIN
select @user_age = i.Age from inserted i
IF (@user_age<13)
BEGIN
Print 'underage'
end
end

-- Trigger to update the number of seats left in gold and silver classes.

CREATE TRIGGER update_tickets_counter ON ticket
FOR INSERT
Not for REPLICATION
AS
BEGIN
declare @Gold int;
declare @Silver int;
declare @class1 varchar(3);
SELECT TOP 1 @class1 = i.class FROM INSERTED i
SELECT @Gold = Seats_Remaining_Gold from Show
where Show_ID = (Select Show_ID from Booking where Booking_ID = ( select top 1 Booking_ID from inserted))
SELECT @Silver = Seats_Remaining_Silver from Show
where Show_ID = (Select Show_ID from Booking where Booking_ID = ( select top 1 Booking_ID from inserted))
if @class1 = 'GLD'
BEGIN
IF @Gold = 0
   BEGIN
   PRINT 'All seats booked'
   END
   ELSE
   BEGIN
   UPDATE Show SET Seats_Remaining_Gold-=1 where show_id = (select show_id from Booking WHERE Booking_ID = (select top 1 Booking_ID from inserted))
   END
END
ELSE
BEGIN
   IF @Silver = 0
   BEGIN
   PRINT 'All seats booked'
   END
   ELSE
   Begin
   UPDATE Show set Seats_Remaining_Silver-=1 where show_id = (select show_id from Booking WHERE Booking_ID = (select top 1 Booking_ID from inserted))
   END
END
END
GO
