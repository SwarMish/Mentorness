SELECT * FROM swarnima.`hotel reservation dataset`;

#1What is the total number of reservations in the dataset?
select count(*) as total_number_of_reservations from swarnima.`hotel reservation dataset`;

#2Which meal plan is the most popular among guests?
select type_of_meal_plan, count(*) as popularity from swarnima.`hotel reservation dataset`
group by type_of_meal_plan
order by popularity desc
limit 1;

#3What is the average price per room for reservations involving children?
Select avg(avg_price_per_room) as Average from swarnima.`hotel reservation dataset` where no_of_children!=0

#4How many reservations were made for the year 20XX (replace XX with the desired year)?
SELECT substring(arrival_date,-4) as year,
count(*) as total_reservations
from swarnima.`hotel reservation dataset`
where substring(arrival_date,-4)='2018' or '2017'
group by year;


#5What is the most commonly booked room type?
select room_type_reserved, count(*) as room_demand from swarnima.`hotel reservation dataset`
group by room_type_reserved
order by room_demand desc
limit  1;

#6How many reservations fall on a weekend (no_of_weekend_nights > 0)?
Select count(*) as no_of_weekend_reservations from swarnima.`hotel reservation dataset`
where no_of_weekend_nights!=0;


#7What is the highest and lowest lead time for reservations?
Select lead_time from swarnima.`hotel reservation dataset`
order by lead_time desc
limit 1;

Select lead_time from swarnima.`hotel reservation dataset`
order by lead_time
limit 1;

#8What is the most common market segment type for reservations?
select market_segment_type, count(*) as market_segment_popularity from swarnima.`hotel reservation dataset`
group by market_segment_type
order by market_segment_type desc
limit 1;


#9How many reservations have a booking status of "Canceled"?
SELECT count(*) as no_of_canceled_bookings FROM swarnima.`hotel reservation dataset`
where booking_status="Canceled";

#10What is the total number of adults and children across all reservations?
select sum(no_of_adults) as total_adults, sum(no_of_children) as total_children
from swarnima.`hotel reservation dataset`;

#11What is the average number of weekend nights for reservations involving children?
select avg(no_of_weekend_nights) as average_number_of_weekend_nights  
from swarnima.`hotel reservation dataset`
where no_of_children!=0;

#12How many reservations were made in each month of the year?
select month(str_to_date(arrival_date,'%d-%m-%y')) as month,
count(*) as total_reservations
from swarnima.`hotel reservation dataset`
group by month(str_to_date(arrival_date,'%d-%m-%y'))
order by month;

#13What is the average number of nights (both weekend and weekday) spent by guests for each room type?
SET SQL_SAFE_UPDATES = 0;
alter table swarnima.`hotel reservation dataset` add column total_no_of_nights int;
update swarnima.`hotel reservation dataset`
set total_no_of_nights = no_of_week_nights + no_of_weekend_nights;

select avg(no_of_week_nights) as average_week_nights,
avg(no_of_weekend_nights) as average_weekend_nights,
avg(total_no_of_nights) as average_total_nights, room_type_reserved
from swarnima.`hotel reservation dataset`
group by room_type_reserved;


#14For reservations involving children, 
#what is the most common room type, 
#and what is the average
#price for that room type?

select room_type_reserved, count(room_type_reserved) as no_of_bookings_per_room_type,
avg(avg_price_per_room) as Average_price
from swarnima.`hotel reservation dataset` where no_of_children!=0
group by room_type_reserved
order by no_of_bookings_per_room_type desc
limit 1;



#15Find the market segment type that generates the highest average price per room.
select market_segment_type, sum(avg_price_per_room)
from swarnima.`hotel reservation dataset`
group by market_segment_type
order by sum(avg_price_per_room) desc
limit 1;