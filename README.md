
-- ১. Users টেবিলে ডেটা ইনসার্ট
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- ২. Matches টেবিলে ডেটা ইনসার্ট
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- ৩. Bookings টেবিলে ডেটা ইনসার্ট
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);



-- ১নং কুয়েরি

SELECT match_id, fixture, base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League' 
  AND match_status = 'Available';

-- ২নং কুয়েরি
SELECT user_id, full_name, email
FROM Users
WHERE full_name ILIKE 'Tanvir%' 
   OR full_name ILIKE '%Haque%';


--৩নং কুয়েরি
SELECT 
    booking_id, 
    user_id, 
    match_id, 
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;

--৪নং কুয়েরি
SELECT 
    b.booking_id, 
    u.full_name, 
    m.fixture, 
    b.total_cost
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Matches m ON b.match_id = m.match_id;

--৫নং কুয়েরি
SELECT 
    u.user_id, 
    u.full_name, 
    b.booking_id
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.user_id;

--৬নং কুয়েরি
SELECT booking_id, match_id, total_cost
FROM Bookings
WHERE total_cost > (SELECT AVG(total_cost) FROM Bookings);

--৭নং কুয়েরি
SELECT match_id, fixture, base_ticket_price
FROM Matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;
