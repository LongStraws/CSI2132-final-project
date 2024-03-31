CREATE DATABASE ehotels;

CREATE TABLE HotelChain (
    ChainID SERIAL PRIMARY KEY,
    CentralOfficeAddress VARCHAR(255) NOT NULL,
    NumberOfHotels INT NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NOT NULL
);

CREATE TABLE Hotel (
    HotelID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
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
	Amenities TEXT,
	Capacity VARCHAR(50) NOT NULL,
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
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Name, Address, Email, ContactPhone) VALUES
(1, 1, 4, 200, 'The Celestial Vista Inn', '100 Broadway Ave, Manhattan, New York, NY, USA', 'hotel1@chain1.com', '101-222-1111'),
(2, 1, 5, 120, 'Sapphire Skies Resort', '200 Liberty St, Manhattan, New York, NY, USA', 'hotel2@chain1.com', '101-333-2222'),
(3, 1, 3, 150, 'The Emerald Retreat', '300 Madison Ave, Manhattan, New York, NY, USA', 'hotel3@chain1.com', '101-444-3333'),
(4, 1, 2, 90, 'Twilight Towers Hotel', '400 Fifth Ave, Manhattan, New York, NY, USA', 'hotel4@chain1.com', '101-555-4444'),
(5, 1, 4, 180, 'The Grandiose Manor', '500 Park Ave, Manhattan, New York, NY, USA', 'hotel5@chain1.com', '101-666-5555'),
(6, 1, 3, 160, 'Azure Horizon Boutique Hotel', '600 Seventh Ave, Manhattan, New York, NY, USA', 'hotel6@chain1.com', '101-777-6666'),
(7, 1, 5, 200, 'The Regal Palms Lodge', '700 Eighth Ave, Manhattan, New York, NY, USA', 'hotel7@chain1.com', '101-888-7777'),
(8, 1, 4, 170, 'Whispering Pines Hideaway', '800 Amsterdam Ave, Manhattan, New York, NY, USA', 'hotel8@chain1.com', '101-999-8888');

-- Hotels for Chain 2
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Name, Address, Email, ContactPhone) VALUES
(9, 2, 3, 150, 'The Velvet Voyage Hotel', '100 King St W, Toronto, ON, Canada', 'hotel1@chain2.com', '202-111-1111'),
(10, 2, 4, 120, 'Oasis Dreams Suites', '200 Bay St, Toronto, ON, Canada', 'hotel2@chain2.com', '202-222-2222'),
(11, 2, 5, 90, 'The Luminous Lagoon Resort', '150 York St, Toronto, ON, Canada', 'hotel3@chain2.com', '202-333-3333'),
(12, 2, 2, 80, 'Midnight Sun Spa & Resort', '101 Queen St W, Toronto, ON, Canada', 'hotel4@chain2.com', '202-444-4444'),
(13, 2, 3, 75, 'The Opulent Oasis Inn', '320 Front St W, Toronto, ON, Canada', 'hotel5@chain2.com', '202-555-5555'),
(14, 2, 4, 85, 'Crystal Cove Boutique Hotel', '33 Gerrard St W, Toronto, ON, Canada', 'hotel6@chain2.com', '202-666-6666'),
(15, 2, 5, 95, 'Serenity Springs Resort', '37 King St E, Toronto, ON, Canada', 'hotel7@chain2.com', '202-777-7777'),
(16, 2, 2, 65, 'Majestic Mountain Lodge', '1 Blue Jays Way, Toronto, ON, Canada', 'hotel8@chain2.com', '202-888-8888'),
(17, 2, 3, 70, 'The Arctic Aurora Hotel', '123 Front St W, Toronto, ON, Canada', 'hotel9@chain2.com', '202-999-9999'),
(18, 2, 4, 110, 'The Golden Dunes Resort', '200 Wellington St W, Toronto, ON, Canada', 'hotel10@chain2.com', '202-101-1010');

-- Hotels for Chain 3
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Name, Address, Email, ContactPhone) VALUES
(19, 3, 4, 200, 'Starlight Serenade Inn', '100 Buckingham Palace Road, London, UK', 'hotel1@chain3.com', '303-111-1111'),
(20, 3, 5, 120, 'The Mystic Meadow Suites', '200 Oxford Street, London, UK', 'hotel2@chain3.com', '303-222-2222'),
(21, 3, 3, 150, 'The Urban Oasis Hotel', '300 Regent Street, London, UK', 'hotel3@chain3.com', '303-333-3333'),
(22, 3, 2, 80, 'The Enchanted Willow Lodge', '400 Strand, London, UK', 'hotel4@chain3.com', '303-444-4444'),
(23, 3, 3, 90, 'The Silver Shadow Resort', '500 Piccadilly, London, UK', 'hotel5@chain3.com', '303-555-5555'),
(24, 3, 4, 110, 'The Tranquil Tides Hotel', '600 Fleet Street, London, UK', 'hotel6@chain3.com', '303-666-6666'),
(25, 3, 5, 130, 'The Infinity Edge Resort', '700 Kingsway, London, UK', 'hotel7@chain3.com', '303-777-7777'),
(26, 3, 2, 70, 'The Cobalt Castle Inn', '800 Baker Street, London, UK', 'hotel8@chain3.com', '303-888-8888'),
(27, 3, 4, 85, 'The Pacific Pearl Hotel', '900 Abbey Road, London, UK', 'hotel9@chain3.com', '303-999-9999'),
(28, 3, 3, 95, 'The Zenith Summit Lodge', '1000 Brompton Road, London, UK', 'hotel10@chain3.com', '303-101-1010'),
(29, 3, 5, 105, 'The Royal Reef Resort', '1100 Victoria Street, London, UK', 'hotel11@chain3.com', '303-202-2020'),
(30, 3, 4, 115, 'The Hidden Gem Boutique Hotel', '1200 Park Lane, London, UK', 'hotel12@chain3.com', '303-303-3030');

-- Hotels for Chain 4
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Name, Address, Email, ContactPhone) VALUES
(31, 4, 3, 150, 'The Horizon Hacienda', '100 George Street, Sydney, NSW, Australia', 'hotel1@chain4.com', '404-111-1111'),
(32, 4, 4, 120, 'The Vintage Vista Villa', '200 Pitt Street, Sydney, NSW, Australia', 'hotel2@chain4.com', '404-222-2222'),
(33, 4, 5, 200, 'The Luxe Lighthouse Inn', '300 Castlereagh Street, Sydney, NSW, Australia', 'hotel3@chain4.com', '404-333-3333'),
(34, 4, 2, 90, 'The Mirage Manor Hotel', '400 Kent Street, Sydney, NSW, Australia', 'hotel4@chain4.com', '404-444-4444'),
(35, 4, 3, 110, 'The Sapphire Springs Spa & Resort', '500 Oxford Street, Sydney, NSW, Australia', 'hotel5@chain4.com', '404-555-5555'),
(36, 4, 4, 130, 'The Golden Galaxy Suites', '600 Crown Street, Sydney, NSW, Australia', 'hotel6@chain4.com', '404-666-6666'),
(37, 4, 2, 70, 'The Radiant Rainforest Retreat', '700 William Street, Sydney, NSW, Australia', 'hotel7@chain4.com', '404-777-7777'),
(38, 4, 5, 160, 'The Whispering Wilds Wilderness Lodge', '800 Elizabeth Street, Sydney, NSW, Australia', 'hotel8@chain4.com', '404-888-8888'),
(39, 4, 3, 140, 'The Celestial City Hotel', '900 Flinders Street, Sydney, NSW, Australia', 'hotel9@chain4.com', '404-999-9999');

-- Hotels for Chain 5
INSERT INTO Hotel (HotelID, ChainID, Rating, NumberOfRooms, Name, Address, Email, ContactPhone) VALUES
(40, 5, 4, 180, 'The Scarlet Sunset Suites', '100 Shinjuku, Tokyo, Japan', 'hotel1@chain5.com', '505-111-1111'),
(41, 5, 5, 210, 'The Azure Archipelago Resort', '200 Shibuya, Tokyo, Japan', 'hotel2@chain5.com', '505-222-2222'),
(42, 5, 3, 120, 'The Majestic Mesa Hotel', '300 Ginza, Tokyo, Japan', 'hotel3@chain5.com', '505-333-3333'),
(43, 5, 2, 100, 'The Lush Lagoon Lodge', '400 Roppongi, Tokyo, Japan', 'hotel4@chain5.com', '505-444-4444'),
(44, 5, 3, 140, 'The Seraphic Skyline Suites', '500 Ueno, Tokyo, Japan', 'hotel5@chain5.com', '505-555-5555'),
(45, 5, 4, 160, 'The Verdant Valley Villa', '600 Asakusa, Tokyo, Japan', 'hotel6@chain5.com', '505-666-6666'),
(46, 5, 5, 130, 'The Opal Oceanfront Oasis', '700 Akihabara, Tokyo, Japan', 'hotel7@chain5.com', '505-777-7777'),
(47, 5, 2, 90, 'The Twilight Terrace Hotel', '800 Harajuku, Tokyo, Japan', 'hotel8@chain5.com', '505-888-8888'),
(48, 5, 4, 150, 'The Crystal Cascade Inn', '900 Odaiba, Tokyo, Japan', 'hotel9@chain5.com', '505-999-9999'),
(49, 5, 3, 110, 'The Moonlit Mesa Motel', '1000 Ikebukuro, Tokyo, Japan', 'hotel10@chain5.com', '505-101-1010'),
(50, 5, 4, 170, 'The Sunlit Shoreline Resort', '1100 Meguro, Tokyo, Japan', 'hotel11@chain5.com', '505-202-2020');

INSERT INTO Room (HotelID, Price, Amenities, Capacity, View, Extendable, Problems) VALUES
(1, 151.58, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(1, 248.83, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(1, 88.40, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(1, 324.49, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(2, 257.95, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(2, 181.61, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(2, 113.06, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(2, 109.45, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(3, 272.31, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(3, 332.12, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(3, 109.74, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(4, 100.48, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(4, 299.78, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(4, 199.20, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(4, 246.64, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(5, 175.27, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(5, 202.51, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(6, 210.06, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(6, 323.74, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(6, 148.67, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(6, 219.06, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(6, 243.00, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(7, 168.26, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(7, 309.52, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(7, 82.40, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(8, 185.06, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(8, 325.83, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(8, 198.15, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(9, 199.12, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(9, 135.14, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(9, 97.87, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(10, 212.16, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(10, 107.53, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(11, 201.93, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(11, 149.61, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(11, 186.58, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(12, 94.30, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(12, 208.46, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(12, 153.23, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(13, 235.31, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(13, 290.40, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(13, 203.20, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(13, 321.65, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(13, 174.75, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(14, 172.05, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(14, 190.52, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(14, 159.79, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(15, 157.75, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(16, 112.07, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(16, 117.15, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(16, 234.49, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(17, 320.21, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(17, 179.72, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(17, 210.27, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(18, 130.57, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(18, 274.65, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(19, 91.44, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(19, 327.00, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(19, 162.82, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(19, 91.26, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(19, 121.90, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(20, 211.70, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(20, 259.56, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(20, 119.48, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(21, 90.11, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(22, 83.62, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(23, 189.57, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(23, 290.41, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(23, 314.90, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(24, 104.35, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(24, 210.47, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(25, 191.35, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(25, 213.84, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(25, 161.08, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(25, 193.36, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(26, 86.08, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(26, 265.63, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(26, 222.75, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(27, 97.54, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(27, 216.27, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(27, 342.00, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(27, 217.40, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(28, 132.21, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(28, 164.74, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(28, 113.08, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(28, 170.02, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(28, 329.08, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(29, 180.94, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(29, 163.23, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(29, 203.60, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(29, 297.72, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(29, 205.27, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(30, 193.92, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(30, 209.42, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(31, 238.99, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(31, 145.18, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(31, 113.12, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(31, 260.36, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(32, 275.93, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(32, 133.55, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(32, 298.03, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(32, 231.52, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(32, 238.73, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(33, 214.31, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(33, 114.96, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(33, 209.82, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(33, 197.50, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(34, 142.31, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(35, 111.38, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(35, 124.50, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(36, 207.33, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(37, 84.98, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(38, 178.06, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(38, 334.30, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(38, 287.73, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(38, 174.40, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(38, 290.11, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(39, 237.22, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(39, 169.99, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(40, 185.00, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(40, 179.41, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(40, 174.64, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(40, 171.90, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(41, 240.96, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(41, 139.68, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(41, 296.89, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(42, 204.55, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(42, 157.85, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(42, 192.59, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(43, 158.79, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(43, 85.15, 'TV, WiFi, Air Conditioning', 'Single', 'City View', false, NULL),
(44, 138.51, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(44, 152.79, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(45, 195.21, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(45, 222.80, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(45, 120.37, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(46, 152.71, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(46, 159.05, 'TV, WiFi, Air Conditioning, Safe', 'Double', 'Garden View', false, NULL),
(46, 183.17, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(46, 262.05, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(47, 246.68, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL),
(47, 157.53, 'TV, WiFi, Air Conditioning, Minibar', 'Family', 'Garden View', true, NULL),
(47, 223.12, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(48, 100.75, 'TV, WiFi, Air Conditioning', 'Single', 'Sea View', false, NULL),
(48, 143.56, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(48, 334.33, 'TV, WiFi, Air Conditioning, Safe', 'Suite', 'City View', true, NULL),
(48, 338.09, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(49, 222.58, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(49, 143.17, 'TV, WiFi, Air Conditioning, Minibar', 'Double', 'Sea View', true, NULL),
(50, 204.24, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Suite', 'Mountain View', true, NULL),
(50, 199.42, 'TV, WiFi, Air Conditioning, Minibar, Safe', 'Family', 'City View', true, NULL);


INSERT INTO Customer (FullName, Address, IDType, IDNumber, RegistrationDate) VALUES
('John Doe', '123 Main St, Anytown, USA', 'Passport', 'A1234567', '2023-01-01'),
('Jane Smith', '456 Maple Ave, Othertown, USA', 'Driver License', 'B2345678', '2023-01-02'),
('Emma Johnson', '789 Oak St, Smalltown, USA', 'Passport', 'C3456789', '2023-01-03'),
('William Brown', '101 Pine St, Villagetown, USA', 'Driver License', 'D4567890', '2023-01-04'),
('Olivia Garcia', '222 Elm St, Countryside, USA', 'Passport', 'E5678901', '2023-01-05'),
('Noah Martinez', '333 Birch St, Hometown, USA', 'Driver License', 'F6789012', '2023-01-06'),
('Sophia Rodriguez', '444 Cedar St, Farmland, USA', 'Passport', 'G7890123', '2023-01-07'),
('Liam Smith', '555 Maple St, Countryside, USA', 'Passport', 'H8901234', '2023-01-08'),
('Olivia Brown', '666 Elm St, Hometown, USA', 'Driver License', 'I9012345', '2023-01-09'),
('Ethan Johnson', '777 Pine St, Farmland, USA', 'Passport', 'J0123456', '2023-01-10'),
('Sophia Wilson', '888 Cedar St, Suburbia, USA', 'Driver License', 'K1234567', '2023-01-11'),
('Mia Anderson', '999 Birch St, Smalltown, USA', 'Passport', 'L2345678', '2023-01-12'),
('Noah Thomas', '1010 Oak St, Villagetown, USA', 'Driver License', 'M3456789', '2023-01-13'),
('Isabella Rodriguez', '1111 Maple St, Countryside, USA', 'Passport', 'N4567890', '2023-01-14'),
('Lucas Lee', '1212 Elm St, Hometown, USA', 'Driver License', 'O5678901', '2023-01-15'),
('Emma Garcia', '1313 Pine St, Farmland, USA', 'Passport', 'P6789012', '2023-01-16'),
('Oliver Rodriguez', '1414 Cedar St, Suburbia, USA', 'Driver License', 'Q7890123', '2023-01-17'),
('Ava Anderson', '1515 Birch St, Smalltown, USA', 'Passport', 'R8901234', '2023-01-18'),
('Liam Martinez', '1616 Oak St, Villagetown, USA', 'Driver License', 'S9012345', '2023-01-19'),
('Olivia Wilson', '1717 Maple St, Countryside, USA', 'Passport', 'T0123456', '2023-01-20'),
('Ethan Brown', '1818 Elm St, Hometown, USA', 'Driver License', 'U1234567', '2023-01-21'),
('Sophia Johnson', '1919 Pine St, Farmland, USA', 'Passport', 'V2345678', '2023-01-22'),
('Mia Wilson', '2020 Cedar St, Suburbia, USA', 'Driver License', 'W3456789', '2023-01-23'),
('Noah Anderson', '2121 Birch St, Smalltown, USA', 'Passport', 'X4567890', '2023-01-24'),
('Isabella Thomas', '2222 Oak St, Villagetown, USA', 'Driver License', 'Y5678901', '2023-01-25'),
('Lucas Wilson', '2323 Maple St, Countryside, USA', 'Passport', 'Z6789012', '2023-01-26'),
('Emma Brown', '2424 Elm St, Hometown, USA', 'Driver License', 'AA7890123', '2023-01-27'),
('Oliver Johnson', '2525 Pine St, Farmland, USA', 'Passport', 'AB8901234', '2023-01-28'),
('Ava Wilson', '2626 Cedar St, Suburbia, USA', 'Driver License', 'AC9012345', '2023-01-29'),
('Liam Anderson', '2727 Birch St, Smalltown, USA', 'Passport', 'AD0123456', '2023-01-30'),
('Olivia Thomas', '2828 Oak St, Villagetown, USA', 'Driver License', 'AE1234567', '2023-01-31'),
('Ethan Wilson', '2929 Maple St, Countryside, USA', 'Passport', 'AF2345678', '2023-02-01'),
('Sophia Brown', '3030 Elm St, Hometown, USA', 'Driver License', 'AG3456789', '2023-02-02');


INSERT INTO Employee (HotelID, FullName, Address, SSN_SIN, Role_Position) VALUES
(1, 'Taylor Johnson', '570 Cherry Lane, Salem, Country', '433-63-7738', 'Concierge'),
(1, 'Morgan Williams', '289 Willow Way, Fairview, Country', '672-34-2438', 'Receptionist'),
(1, 'Jordan Davis', '865 Pine Lane, Arlington, Country', '289-32-3355', 'Manager'),
(1, 'Alex Johnson', '819 Pine Lane, East Franklin, Country', '416-65-3101', 'Maintenance'),
(2, 'Alex Brown', '805 Willow Way, Madison, Country', '991-79-2478', 'Receptionist'),
(2, 'Alex Rodriguez', '231 Maple Street, East Franklin, Country', '729-82-8492', 'Concierge'),
(3, 'Skyler Williams', '975 Maple Street, West Clinton, Country', '723-29-4581', 'Housekeeping'),
(3, 'Blair Garcia', '533 Magnolia Path, South Riverside, Country', '576-19-4524', 'Manager'),
(3, 'Casey Miller', '387 Oak Avenue, Georgetown, Country', '951-75-7072', 'Manager'),
(3, 'Taylor Davis', '129 Birch Road, North Springfield, Country', '301-57-7806', 'Concierge'),
(3, 'Skyler Rodriguez', '408 Elm Drive, Fairview, Country', '826-50-2543', 'Waiter'),
(4, 'Taylor Johnson', '980 Birch Road, East Franklin, Country', '939-93-1032', 'Concierge'),
(4, 'Skyler Smith', '158 Maple Street, Arlington, Country', '659-44-4055', 'Manager'),
(5, 'Skyler Garcia', '299 Cedar Blvd, West Clinton, Country', '132-94-5100', 'Maintenance'),
(5, 'Morgan Jones', '220 Pine Lane, Fairview, Country', '754-85-5067', 'Concierge'),
(5, 'Jamie Jones', '778 Pine Lane, Fairview, Country', '886-71-7871', 'Receptionist'),
(6, 'Sam Brown', '531 Oak Avenue, East Franklin, Country', '873-42-7950', 'Maintenance'),
(6, 'Blair Smith', '876 Willow Way, East Franklin, Country', '448-57-4448', 'Security'),
(7, 'Casey Davis', '293 Cherry Lane, Ashland, Country', '750-80-1665', 'Manager'),
(7, 'Taylor Jones', '445 Cherry Lane, Madison, Country', '367-60-1621', 'Housekeeping'),
(7, 'Jordan Williams', '731 Cedar Blvd, Fairview, Country', '291-24-2262', 'Concierge'),
(7, 'Dakota Smith', '167 Willow Way, Fairview, Country', '440-25-5210', 'Waiter'),
(8, 'Sam Garcia', '768 Cedar Blvd, South Riverside, Country', '929-23-1289', 'Chef'),
(8, 'Sam Garcia', '283 Cedar Blvd, East Franklin, Country', '662-88-8883', 'Security'),
(8, 'Alex Davis', '252 Pine Lane, Arlington, Country', '630-23-2713', 'Manager'),
(8, 'Dakota Wilson', '666 Magnolia Path, Ashland, Country', '998-27-2382', 'Chef'),
(9, 'Sam Garcia', '877 Pine Lane, Ashland, Country', '734-51-2757', 'Security'),
(9, 'Skyler Davis', '877 Oak Avenue, East Franklin, Country', '721-70-5472', 'Manager'),
(9, 'Blair Davis', '121 Birch Road, Madison, Country', '788-94-1176', 'Maintenance'),
(9, 'Alex Johnson', '579 Pine Lane, Ashland, Country', '213-19-8828', 'Waiter'),
(10, 'Jamie Johnson', '690 Elm Drive, South Riverside, Country', '871-99-6241', 'Concierge'),
(10, 'Jordan Garcia', '920 Pine Lane, Fairview, Country', '251-49-1617', 'Receptionist'),
(10, 'Morgan Rodriguez', '573 Maple Street, Arlington, Country', '913-27-7333', 'Manager'),
(10, 'Jordan Garcia', '190 Magnolia Path, West Clinton, Country', '596-48-5368', 'Waiter'),
(11, 'Alex Garcia', '692 Oak Avenue, North Springfield, Country', '659-62-5280', 'Maintenance'),
(11, 'Sam Wilson', '877 Oak Avenue, North Springfield, Country', '958-48-8751', 'Waiter'),
(11, 'Sam Wilson', '931 Maple Street, North Springfield, Country', '564-44-6253', 'Security'),
(12, 'Skyler Garcia', '851 Cherry Lane, South Riverside, Country', '276-29-4601', 'Concierge'),
(13, 'Dakota Smith', '463 Willow Way, West Clinton, Country', '695-61-8019', 'Manager'),
(13, 'Sam Rodriguez', '447 Magnolia Path, Salem, Country', '543-86-7510', 'Manager'),
(14, 'Taylor Garcia', '841 Pine Lane, East Franklin, Country', '788-15-3132', 'Concierge'),
(14, 'Jordan Brown', '995 Pine Lane, East Franklin, Country', '913-90-8585', 'Receptionist'),
(14, 'Taylor Brown', '749 Elm Drive, Ashland, Country', '749-72-7446', 'Concierge'),
(15, 'Morgan Garcia', '914 Cedar Blvd, Salem, Country', '941-57-4123', 'Chef'),
(16, 'Jordan Miller', '10 Downing St, London, UK', '123-45-6789', 'Manager'),
(16, 'Alex Taylor', '221B Baker St, London, UK', '987-65-4321', 'Chef'),
(17, 'Samuel Lee', '1 Infinite Loop, Cupertino, USA', '234-56-7890', 'Security'),
(17, 'Casey Kim', '1600 Amphitheatre Parkway, Mountain View, USA', '876-54-3210', 'Receptionist'),
(18, 'Taylor Morgan', '350 5th Ave, New York, USA', '345-67-8901', 'Concierge'),
(18, 'Jamie Rivera', '4059 Mt Lee Dr, Hollywood, USA', '765-43-2109', 'Housekeeping'),
(19, 'Morgan Bailey', '48 Pirrama Rd, Sydney, Australia', '456-78-9012', 'Waiter'),
(19, 'Jordan Casey', '1 Driver Ave, Moore Park, Australia', '654-32-1098', 'Maintenance'),
(20, 'Alexis Jordan', '1-1-2 Otemachi, Chiyoda, Tokyo, Japan', '567-89-0123', 'Manager'),
(20, 'Sam Parker', '2-4-1 Nishi-Shinjuku, Shinjuku, Tokyo, Japan', '543-21-0987', 'Receptionist'),
(21, 'Liam Chen', '798 Nanjing Rd, Shanghai, China', '789-01-2345', 'Manager'),
(21, 'Olivia Wang', '380 Huangpi S Rd, Shanghai, China', '890-12-3456', 'Receptionist'),
(22, 'Noah Zhang', '1 Sheikh Mohammed bin Rashid Blvd, Dubai, UAE', '901-23-4567', 'Chef'),
(22, 'Emma Al Hashimi', 'Palm Jumeirah, Dubai, UAE', '012-34-5678', 'Housekeeping'),
(23, 'William Kim', '123 Han River St, Seoul, South Korea', '123-45-6789', 'Security'),
(23, 'Sophia Park', '456 Bukchon Ro, Seoul, South Korea', '234-56-7890', 'Concierge'),
(24, 'James Kiprotich', '890 Safari Dr, Nairobi, Kenya', '345-67-8901', 'Waiter'),
(24, 'Isabella Njeri', '321 Maasai Mara, Narok, Kenya', '456-78-9012', 'Maintenance'),
(25, 'Lucas Rossi', 'Via Condotti, 00187 Rome, Italy', '567-89-0123', 'Manager'),
(25, 'Mia Bianchi', 'Piazza del Colosseo, Rome, Italy', '678-90-1234', 'Chef'),
(26, 'Ethan Santos', 'Avenida Atlântica, Rio de Janeiro, Brazil', '789-01-2345', 'Manager'),
(26, 'Sophie Oliveira', 'Praça Mauá, Rio de Janeiro, Brazil', '890-12-3456', 'Concierge'),
(26, 'Miguel Costa', 'Rua Farme de Amoedo, Rio de Janeiro, Brazil', '901-23-4567', 'Security'),
(27, 'Charlotte Dubois', '15 Rue de Vaugirard, Paris, France', '012-34-5678', 'Receptionist'),
(27, 'Gabriel Moreau', '5 Rue de Rivoli, Paris, France', '123-45-6789', 'Chef'),
(28, 'Ava Smith', '1600 Pennsylvania Ave NW, Washington, DC, USA', '234-56-7890', 'Housekeeping'),
(29, 'Oliver Johnson', '10 Bayfront Avenue, Singapore', '345-67-8901', 'Manager'),
(29, 'Amelia Tan', 'Marina Bay Sands, Singapore', '456-78-9012', 'Receptionist'),
(29, 'Ethan Lim', 'Gardens by the Bay, Singapore', '567-89-0123', 'Chef'),
(30, 'Isaac Patel', 'Gate 1, Harmandir Sahib, Amritsar, India', '678-90-1234', 'Security'),
(30, 'Zoe Singh', 'Rajpath, New Delhi, India', '789-01-2345', 'Concierge'),
(30, 'Aryan Kaur', 'Marine Drive, Mumbai, India', '890-12-3456', 'Waiter'),
(30, 'Emma Gupta', 'Victoria Memorial, Kolkata, India', '901-23-4567', 'Housekeeping'),
(31, 'Liam Nguyen', 'Ben Thanh Market, Ho Chi Minh City, Vietnam', '789-01-2345', 'Manager'),
(31, 'Olivia Tran', 'Lam Son Square, Ho Chi Minh City, Vietnam', '890-12-3456', 'Receptionist'),
(32, 'Noah Kim', 'Bukchon Hanok Village, Seoul, South Korea', '901-23-4567', 'Chef'),
(32, 'Emma Choi', 'N Seoul Tower, Seoul, South Korea', '012-34-5678', 'Housekeeping'),
(32, 'Jacob Park', '63 Building, Seoul, South Korea', '123-45-6789', 'Security'),
(33, 'Ava Gonzalez', 'Plaza Mayor, Madrid, Spain', '234-56-7890', 'Concierge'),
(33, 'Sophia Fernandez', 'Gran Vía, Madrid, Spain', '345-67-8901', 'Waiter'),
(33, 'Mason Martinez', 'El Retiro Park, Madrid, Spain', '456-78-9012', 'Maintenance'),
(34, 'Isabella Rossi', 'Colosseum, Rome, Italy', '567-89-0123', 'Manager'),
(34, 'Ethan Bianchi', 'Trevi Fountain, Rome, Italy', '678-90-1234', 'Chef'),
(35, 'Charlotte Murphy', 'Cliffs of Moher, County Clare, Ireland', '789-01-2345', 'Receptionist'),
(35, 'Lucas Muller', 'Temple Bar, Dublin, Ireland', '890-12-3456', 'Security'),
(35, 'Mia Byrne', 'St. Stephens Green, Dublin, Ireland', '901-23-4567', 'Housekeeping'),
(35, 'Amelia Walsh', 'Guinness Storehouse, Dublin, Ireland', '012-34-5678', 'Concierge'),
(36, 'Ethan Oluwaseun', 'Freedom Park, Lagos, Nigeria', '789-01-2345', 'Manager'),
(36, 'Olivia Adebowale', 'Lekki Conservation Centre, Lagos, Nigeria', '890-12-3456', 'Receptionist'),
(36, 'Noah Abiodun', 'Ikeja City Mall, Lagos, Nigeria', '901-23-4567', 'Security'),
(37, 'Emma Kowalska', 'Old Town Market Square, Warsaw, Poland', '012-34-5678', 'Chef'),
(37, 'Jacob Nowak', 'Łazienki Park, Warsaw, Poland', '123-45-6789', 'Housekeeping'),
(37, 'Sophia Wiśniewska', 'Palace of Culture and Science, Warsaw, Poland', '234-56-7890', 'Concierge'),
(38, 'Ava Smith', 'Bondi Beach, Sydney, Australia', '345-67-8901', 'Manager'),
(38, 'Liam Brown', 'Sydney Opera House, Sydney, Australia', '456-78-9012', 'Waiter'),
(39, 'Oliver García', 'Antigua Guatemala, Sacatepéquez, Guatemala', '567-89-0123', 'Chef'),
(39, 'Isabella Hernández', 'Lake Atitlán, Sololá, Guatemala', '678-90-1234', 'Receptionist'),
(39, 'Ethan Pérez', 'Tikal National Park, Petén, Guatemala', '789-01-2345', 'Maintenance'),
(40, 'Charlotte Johnson', 'Times Square, New York, USA', '890-12-3456', 'Manager'),
(40, 'Lucas Lee', 'Central Park, New York, USA', '901-23-4567', 'Security'),
(40, 'Mia Davis', 'Empire State Building, New York, USA', '012-34-5678', 'Housekeeping'),
(41, 'James Patel', 'Gateway of India, Mumbai, India', '789-01-2345', 'Manager'),
(41, 'Sofia Khan', 'Marine Drive, Mumbai, India', '890-12-3456', 'Receptionist'),
(41, 'Aarav Singh', 'Colaba Causeway, Mumbai, India', '901-23-4567', 'Chef'),
(42, 'Mia Wang', 'The Bund, Shanghai, China', '012-34-5678', 'Housekeeping'),
(42, 'Ethan Zhou', 'Jade Buddha Temple, Shanghai, China', '123-45-6789', 'Security'),
(43, 'Olivia Martinez', 'La Rambla, Barcelona, Spain', '234-56-7890', 'Concierge'),
(43, 'Lucas Hernández', 'Park Guell, Barcelona, Spain', '345-67-8901', 'Waiter'),
(43, 'Isabella López', 'Sagrada Família, Barcelona, Spain', '456-78-9012', 'Chef'),
(44, 'Noah Murphy', 'Cliff of Moher Visitor Experience, Liscannor, Ireland', '567-89-0123', 'Manager'),
(44, 'Emma Phils', 'Guinness Storehouse, Dublin, Ireland', '678-90-1234', 'Receptionist'),
(44, 'Liam Walsh', 'Croke Park, Dublin, Ireland', '789-01-2345', 'Maintenance'),
(45, 'Charlotte Johnson', 'Banff National Park, Alberta, Canada', '890-12-3456', 'Manager'),
(45, 'Oliver Smith', 'Lake Louise, Alberta, Canada', '901-23-4567', 'Security'),
(45, 'Ava Brown', 'Jasper National Park, Alberta, Canada', '012-34-5678', 'Housekeeping'),
(45, 'William Tremblay', 'Moraine Lake, Alberta, Canada', '123-45-6789', 'Concierge'),
(46, 'Sophia Kim', 'Bukhansan National Park, Seoul, South Korea', '789-01-2345', 'Manager'),
(46, 'Ethan Choi', 'Myeongdong, Seoul, South Korea', '890-12-3456', 'Chef'),
(46, 'Ava Park', 'Gyeongbokgung Palace, Seoul, South Korea', '901-23-4567', 'Receptionist'),
(47, 'Liam Jones', 'Royal Botanic Gardens, Melbourne, Australia', '012-34-5678', 'Security'),
(47, 'Olivia Brown', 'Federation Square, Melbourne, Australia', '123-45-6789', 'Housekeeping'),
(48, 'Noah García', 'Chichen Itza, Yucatan, Mexico', '234-56-7890', 'Concierge'),
(48, 'Emma Martinez', 'Cenote Ik Kil, Yucatan, Mexico', '345-67-8901', 'Waiter'),
(48, 'Jacob Hernández', 'El Castillo, Yucatan, Mexico', '456-78-9012', 'Maintenance'),
(49, 'Isabella Rossi', 'Ponte Vecchio, Florence, Italy', '567-89-0123', 'Manager'),
(49, 'Mason Bianchi', 'Uffizi Gallery, Florence, Italy', '678-90-1234', 'Chef'),
(49, 'Mia Ferrari', 'Piazza della Signoria, Florence, Italy', '789-01-2345', 'Receptionist'),
(50, 'William Johnson', 'Table Mountain, Cape Town, South Africa', '890-12-3456', 'Manager'),
(50, 'Charlotte van der Merwe', 'Robben Island, Cape Town, South Africa', '901-23-4567', 'Security'),
(50, 'Oliver de Villiers', 'Kirstenbosch National Botanical Garden, Cape Town, South Africa', '012-34-5678', 'Housekeeping'),
(50, 'Sophia Botha', 'V&A Waterfront, Cape Town, South Africa', '123-45-6789', 'Concierge');

-- Booking for Room 101
INSERT INTO Booking (RoomID, CustomerID, EmployeeID, StartDate, EndDate) 
VALUES 
(101, (SELECT CustomerID FROM Customer WHERE FullName = 'Sophia Brown'), 81, '2024-04-01', '2024-04-05'),
(101, (SELECT CustomerID FROM Customer WHERE FullName = 'Ethan Wilson'), 82, '2024-04-02', '2024-04-06');

-- Booking for Room 34
INSERT INTO Booking (RoomID, CustomerID, EmployeeID, StartDate, EndDate) 
VALUES 
(34, (SELECT CustomerID FROM Customer WHERE FullName = 'Emma Garcia'), 31, '2024-04-03', '2024-04-07'),
(34, (SELECT CustomerID FROM Customer WHERE FullName = 'Oliver Johnson'), 33, '2024-04-04', '2024-04-08');

-- Booking for Hotel 12
INSERT INTO Booking (RoomID, CustomerID, EmployeeID, StartDate, EndDate) 
VALUES 
(12, (SELECT CustomerID FROM Customer WHERE FullName = 'Sophia Rodriguez'), 7, '2024-04-05', '2024-04-09'),
(12, (SELECT CustomerID FROM Customer WHERE FullName = 'Mia Anderson'), 10, '2024-04-06', '2024-04-10');

-- Booking for Hotel 72
INSERT INTO Booking (RoomID, CustomerID, EmployeeID, StartDate, EndDate) 
VALUES 
(72, (SELECT CustomerID FROM Customer WHERE FullName = 'Isabella Rodriguez'), 61, '2024-04-07', '2024-04-11'),
(72, (SELECT CustomerID FROM Customer WHERE FullName = 'Lucas Wilson'), 61, '2024-04-08', '2024-04-12');

-- Booking for Room 50
INSERT INTO Booking (RoomID, CustomerID, EmployeeID, StartDate, EndDate) 
VALUES 
(50, (SELECT CustomerID FROM Customer WHERE FullName = 'Sophia Brown'), 44, '2024-04-09', '2024-04-13'),
(50, (SELECT CustomerID FROM Customer WHERE FullName = 'Ethan Wilson'), 44, '2024-04-10', '2024-04-14');


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
WHERE Customer.FullName = 'Sophia Brown';

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
SELECT h.Name AS HotelName, COUNT(r.Capacity) AS TotalCapacity
FROM Room r
JOIN Hotel h ON r.HotelID = h.HotelID
GROUP BY h.Name;