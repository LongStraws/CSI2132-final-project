
CREATE TABLE HotelChain (
    ChainID SERIAL PRIMARY KEY,
    CentralOfficeAddress VARCHAR(255) NOT NULL,
    NumberOfHotels INT NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NOT NULL
);

CREATE TABLE Hotel (
    HotelID SERIAL PRIMARY KEY,
    ChainID INT REFERENCES HotelChain(ChainID),
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    NumberOfRooms INT NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    ContactPhone VARCHAR(20) NOT NULL
);

CREATE TABLE Room (
	RoomID SERIAL PRIMARY KEY,
	HotelID INT REFERENCES Hotel(HotelID),
	Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
	Amenitites TEXT,
	Capacity VARHCHAR(50) NOT NULL,
	View VARCHAR(50),
	Extendable BOOLEAN NOT NULL, 
	Problems TEXT
);

CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    IDType VARCHAR(50) NOT NULL,
    IDNumber VARCHAR(50) NOT NULL,
    RegistrationDate DATE NOT NULL
);

CREATE TABLE Employee (
    EmployeeID SERIAL PRIMARY KEY,
    HotelID INT REFERENCES Hotel(HotelID),
    FullName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    SSN_SIN VARCHAR(50) NOT NULL,
    Role_Position VARCHAR(100) NOT NULL
);

CREATE TABLE Booking (
    BookingID SERIAL PRIMARY KEY,
    RoomID INT REFERENCES Room(RoomID),
    CustomerID INT REFERENCES Customer(CustomerID),
    EmployeeID INT REFERENCES Employee(EmployeeID),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL CHECK (EndDate >= StartDate)
);

CREATE TABLE Renting (
    RentingID SERIAL PRIMARY KEY,
    BookingID INT REFERENCES Booking(BookingID),
    RoomID INT REFERENCES Room(RoomID),
    CustomerID INT REFERENCES Customer(CustomerID),
    EmployeeID INT REFERENCES Employee(EmployeeID),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL CHECK (EndDate >= StartDate)
);

INSERT INTO HotelChain (ChainID, CentralOfficeAddress, NumberOfHotels, Email, Phone) VALUES
(1, '123 Chain Ave, New York, USA', 8, 'chain1@example.com', '111-222-3333'),
(2, '456 Chain St, Toronto, Canada', 10, 'chain2@example.com', '222-333-4444'),
(3, '789 Chain Blvd, London, UK', 12, 'chain3@example.com', '333-444-5555'),
(4, '101 Chain Rd, Sydney, Australia', 9, 'chain4@example.com', '444-555-6666'),
(5, '202 Chain Way, Tokyo, Japan', 11, 'chain5@example.com', '555-666-7777');

-- Hotels for Chain 1
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Address, Email, ContactPhone) VALUES
(1, 1, 4, 200, '100 Broadway Ave, Manhattan, New York, NY, USA', 'hotel1@chain1.com', '101-222-1111'),
(2, 1, 5, 120, '200 Liberty St, Manhattan, New York, NY, USA', 'hotel2@chain1.com', '101-333-2222'),
(3, 1, 3, 150, '300 Madison Ave, Manhattan, New York, NY, USA', 'hotel3@chain1.com', '101-444-3333'),
(4, 1, 2, 90, '400 Fifth Ave, Manhattan, New York, NY, USA', 'hotel4@chain1.com', '101-555-4444'),
(5, 1, 4, 180, '500 Park Ave, Manhattan, New York, NY, USA', 'hotel5@chain1.com', '101-666-5555'),
(6, 1, 3, 160, '600 Seventh Ave, Manhattan, New York, NY, USA', 'hotel6@chain1.com', '101-777-6666'),
(7, 1, 5, 200, '700 Eighth Ave, Manhattan, New York, NY, USA', 'hotel7@chain1.com', '101-888-7777'),
(8, 1, 4, 170, '800 Amsterdam Ave, Manhattan, New York, NY, USA', 'hotel8@chain1.com', '101-999-8888');

-- Hotels for Chain 2
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Address, Email, ContactPhone) VALUES
(1, 2, 3, 150, '100 King St W, Toronto, ON, Canada', 'hotel1@chain2.com', '202-111-1111'),
(2, 2, 4, 120, '200 Bay St, Toronto, ON, Canada', 'hotel2@chain2.com', '202-222-2222'),
(3, 2, 5, 90, '150 York St, Toronto, ON, Canada', 'hotel3@chain2.com', '202-333-3333'),
(4, 2, 2, 80, '101 Queen St W, Toronto, ON, Canada', 'hotel4@chain2.com', '202-444-4444'),
(5, 2, 3, 75, '320 Front St W, Toronto, ON, Canada', 'hotel5@chain2.com', '202-555-5555'),
(6, 2, 4, 85, '33 Gerrard St W, Toronto, ON, Canada', 'hotel6@chain2.com', '202-666-6666', 6),
(7, 2, 5, 95, '37 King St E, Toronto, ON, Canada', 'hotel7@chain2.com', '202-777-7777'),
(8, 2, 2, 65, '1 Blue Jays Way, Toronto, ON, Canada', 'hotel8@chain2.com', '202-888-8888'),
(9, 2, 3, 70, '123 Front St W, Toronto, ON, Canada', 'hotel9@chain2.com', '202-999-9999'),
(10, 2, 4, 110, '200 Wellington St W, Toronto, ON, Canada', 'hotel10@chain2.com', '202-101-1010');

-- Hotels for Chain 3
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Address, Email, ContactPhone) VALUES
(1, 3, 4, 200, '100 Buckingham Palace Road, London, UK', 'hotel1@chain3.com', '303-111-1111'),
(2, 3, 5, 120, '200 Oxford Street, London, UK', 'hotel2@chain3.com', '303-222-2222'),
(3, 3, 3, 150, '300 Regent Street, London, UK', 'hotel3@chain3.com', '303-333-3333'),
(4, 3, 2, 80, '400 Strand, London, UK', 'hotel4@chain3.com', '303-444-4444'),
(5, 3, 3, 90, '500 Piccadilly, London, UK', 'hotel5@chain3.com', '303-555-5555'),
(6, 3, 4, 110, '600 Fleet Street, London, UK', 'hotel6@chain3.com', '303-666-6666'),
(7, 3, 5, 130, '700 Kingsway, London, UK', 'hotel7@chain3.com', '303-777-7777'),
(8, 3, 2, 70, '800 Baker Street, London, UK', 'hotel8@chain3.com', '303-888-8888'),
(9, 3, 4, 85, '900 Abbey Road, London, UK', 'hotel9@chain3.com', '303-999-9999'),
(10, 3, 3, 95, '1000 Brompton Road, London, UK', 'hotel10@chain3.com', '303-101-1010'),
(11, 3, 5, 105, '1100 Victoria Street, London, UK', 'hotel11@chain3.com', '303-202-2020'),
(12, 3, 4, 115, '1200 Park Lane, London, UK', 'hotel12@chain3.com', '303-303-3030');

-- Hotels for Chain 4
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Address, Email, ContactPhone) VALUES
(1, 4, 3, 150, '100 George Street, Sydney, NSW, Australia', 'hotel1@chain4.com', '404-111-1111'),
(2, 4, 4, 120, '200 Pitt Street, Sydney, NSW, Australia', 'hotel2@chain4.com', '404-222-2222'),
(3, 4, 5, 200, '300 Castlereagh Street, Sydney, NSW, Australia', 'hotel3@chain4.com', '404-333-3333'),
(4, 4, 2, 90, '400 Kent Street, Sydney, NSW, Australia', 'hotel4@chain4.com', '404-444-4444'),
(5, 4, 3, 110, '500 Oxford Street, Sydney, NSW, Australia', 'hotel5@chain4.com', '404-555-5555'),
(6, 4, 4, 130, '600 Crown Street, Sydney, NSW, Australia', 'hotel6@chain4.com', '404-666-6666'),
(7, 4, 2, 70, '700 William Street, Sydney, NSW, Australia', 'hotel7@chain4.com', '404-777-7777'),
(8, 4, 5, 160, '800 Elizabeth Street, Sydney, NSW, Australia', 'hotel8@chain4.com', '404-888-8888'),
(9, 4, 3, 140, '900 Flinders Street, Sydney, NSW, Australia', 'hotel9@chain4.com', '404-999-9999');

-- Hotels for Chain 5
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Address, Email, ContactPhone) VALUES
(1, 5, 4, 180, '100 Shinjuku, Tokyo, Japan', 'hotel1@chain5.com', '505-111-1111'),
(2, 5, 5, 210, '200 Shibuya, Tokyo, Japan', 'hotel2@chain5.com', '505-222-2222'),
(3, 5, 3, 120, '300 Ginza, Tokyo, Japan', 'hotel3@chain5.com', '505-333-3333'),
(4, 5, 2, 100, '400 Roppongi, Tokyo, Japan', 'hotel4@chain5.com', '505-444-4444'),
(5, 5, 3, 140, '500 Ueno, Tokyo, Japan', 'hotel5@chain5.com', '505-555-5555'),
(6, 5, 4, 160, '600 Asakusa, Tokyo, Japan', 'hotel6@chain5.com', '505-666-6666'),
(7, 5, 5, 130, '700 Akihabara, Tokyo, Japan', 'hotel7@chain5.com', '505-777-7777'),
(8, 5, 2, 90, '800 Harajuku, Tokyo, Japan', 'hotel8@chain5.com', '505-888-8888'),
(9, 5, 4, 150, '900 Odaiba, Tokyo, Japan', 'hotel9@chain5.com', '505-999-9999'),
(10, 5, 3, 110, '1000 Ikebukuro, Tokyo, Japan', 'hotel10@chain5.com', '505-101-1010'),
(11, 5, 4, 170, '1100 Meguro, Tokyo, Japan', 'hotel11@chain5.com', '505-202-2020');

INSERT INTO Customer (FullName, Address, IDType, IDNumber, RegistrationDate) VALUES
('John Doe', '123 Main St, Anytown, USA', 'Passport', 'A1234567', '2023-01-01'),
('Jane Smith', '456 Maple Ave, Othertown, USA', 'Driver License', 'B2345678', '2023-01-02');

INSERT INTO Employee (HotelID, FullName, Address, SSN_SIN, Role_Position) VALUES
(1, 'Alice Johnson', '123 Employee St, CityA, Country', '123-45-6789', 'Manager'),
(1, 'Bob Smith', '456 Employee Rd, CityA, Country', '987-65-4321', 'Receptionist');

INSERT INTO Room (HotelID, Price, Amenities, Capacity, View, Extendable, Problems) VALUES
(1, 100.00, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(1, 150.00, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL);

INSERT INTO Booking (RoomID, CustomerID, EmployeeID, StartDate, EndDate) VALUES
(1, (SELECT CustomerID FROM Customer WHERE FullName = 'John Doe'), 1, '2023-05-01', '2023-05-05'),
(2, (SELECT CustomerID FROM Customer WHERE FullName = 'Jane Smith'), 2, '2023-06-01', '2023-06-05');

-- 2c 
-- query to count the number of hotels in each hotel chain
SELECT ChainID, COUNT(*) AS NumberOfHotels FROM Hotel GROUP BY ChainID;

-- nested query to find all the hotels that have a higher number of rooms than the average number of room per hotel in the database
SELECT * FROM Hotel WHERE NumberOfRooms > (SELECT AVG(NumberOfRooms) FROM Hotel);

-- query to get all info about hotels in Tokyo
SELECT * FROM Hotel WHERE Address LIKE '%Tokyo, Japan%';

-- query to get a list of all bookings for a particular customer by joining the booking and customer tables.
SELECT Booking.BookingID, Customer.FullName, Booking.StartDate, Booking.EndDate 
FROM Booking 
JOIN Customer ON Booking.CustomerID = Customer.CustomerID 
WHERE Customer.FullName = 'John Doe';

-- 2d
-- trigger to ensure a room is available before a booking is made
CREATE OR REPLACE FUNCTION check_room_availability()
RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (
      SELECT 1 
      FROM Booking 
      WHERE RoomID = NEW.RoomID 
      AND NOT (NEW.StartDate > EndDate OR NEW.EndDate < StartDate)
    ) THEN
    RAISE EXCEPTION 'The room is not available for the requested dates.';
  END IF;
  RETURN NEW;
END;

CREATE TRIGGER trg_check_room_availability
BEFORE INSERT ON Booking
FOR EACH ROW EXECUTE FUNCTION check_room_availability();

-- trigger to ensure that a room's problem must be addressed before it can be rented out again
CREATE OR REPLACE FUNCTION check_room_problems_before_renting()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.Problems IS NOT NULL AND OLD.Problems <> '' AND NEW.BookingID IS NOT NULL THEN
    RAISE EXCEPTION 'This room has unresolved problems and cannot be booked or rented.';
  END IF;
  RETURN NEW;
END;

CREATE TRIGGER trg_check_room_problems_before_renting
BEFORE INSERT OR UPDATE ON Booking
FOR EACH ROW EXECUTE FUNCTION check_room_problems_before_renting();

-- 2e
-- Index 1: Index on Booking(StartDate, EndDate)
-- this index would be beneficial if needed to frequently query bookings by start and end dates. This index would help to speed up the search.
CREATE INDEX idx_booking_dates ON Booking (StartDate, EndDate);

-- Index 2: Index on Booking(RoomID)
-- this index would be beneficial if needed to find all bookings for a specific room to check availability for example. This index would help to speed up the search.
CREATE INDEX idx_booking_room ON Booking (RoomID);

-- Index 3: Index on Room(HotelID)
-- this index would be beneficial if needed to find all rooms for a specific hotel to check/perform maintenance or check availability. This index would help to speed up the search.
CREATE INDEX idx_room_hotel ON Room (HotelID);


-- 2f
-- View 1: Number of available rooms per area
CREATE VIEW AvailableRoomsPerArea AS
SELECT h.Address AS Area, COUNT(r.RoomID) AS AvailableRooms
FROM Room r
JOIN Hotel h ON r.HotelID = h.HotelID
WHERE r.RoomID NOT IN (SELECT RoomID FROM Booking WHERE EndDate > CURRENT_DATE)
GROUP BY h.Address;

-- View 2: Aggregated capacity of all the rooms of a specific hotel
CREATE VIEW HotelCapacity AS
SELECT h.Name AS HotelName, SUM(r.Capacity) AS TotalCapacity
FROM Room r
JOIN Hotel h ON r.HotelID = h.HotelID
GROUP BY h.Name;