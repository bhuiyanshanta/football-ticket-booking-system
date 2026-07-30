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
