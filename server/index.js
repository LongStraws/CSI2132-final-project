const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");
const { format } = require('date-fns');

//middleware
app.use(cors());
app.use(express.json());

//view1
app.get("/view1", async (req, res) => {
  try {
    const viewData = await pool.query(
      "SELECT * FROM public.availableroomsperarea"
    );
    res.json(viewData.rows);
  } catch (err) {
    console.error("Database query error:", err.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

//view2
app.get("/view2", async (req, res) => {
  try {
    const viewData = await pool.query("SELECT * FROM public.hotelcapacity");
    res.json(viewData.rows);
  } catch (err) {
    console.error("Database query error:", err.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

//get customers
app.get("/customers", async (req, res) => {
  try {
    const viewData = await pool.query(
      `SELECT * FROM public.customer
       ORDER BY customerid ASC`
    );
    res.json(viewData.rows);
  } catch (err) {
    console.error("Database query error:", err.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

//get customer
app.get("/customer/:customerId", async (req, res) => {
  try {
    const viewData = await pool.query(
      `SELECT * FROM Customer WHERE CustomerId = ${req.params.customerId}`
    );
    res.json(viewData.rows);
  } catch (err) {
    console.error("Database query error:", err.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

//create customer
app.post('/customer', async (req, res) => {
  const { fullName, address, idType, idNumber } = req.body;

  // Automatically set registration date to current date
  const registrationDate = format(new Date(), 'yyyy-MM-dd');

  // SQL query to insert customer
  const query = `
    INSERT INTO Customer (FullName, Address, IDType, IDNumber, RegistrationDate) 
    VALUES 
    ($1, $2, $3, $4, $5)
  `;

  try {
    await pool.query(query, [fullName, address, idType, idNumber, registrationDate]);
    res.status(201).send('Customer added successfully');
  } catch (err) {
    console.error('Error adding customer', err);
    res.status(500).send('Failed to add customer');
  }
});

//get all bookings
app.get("/bookings", async (req, res) => {
  try {
    let query = `SELECT * FROM booking 
                 ORDER BY bookingid ASC`;
    // Check if customer parameter is provided
    if (req.query.customer) {
      const customer = req.query.customer;
      query = `
        SELECT Booking.BookingID, Customer.FullName, Booking.StartDate, Booking.EndDate 
        FROM Booking 
        JOIN Customer ON Booking.CustomerID = Customer.CustomerID 
        WHERE Customer.FullName = '${customer}'
        `;
    }
    const viewData = await pool.query(query);
    res.json(viewData.rows);
  } catch (err) {
    console.error("Database query error:", err.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

//book customer
app.post('/book', async (req, res) => {
  const { roomId, customerFullName, employeeId, startDate, endDate } = req.body;

  // SQL query to insert booking
  const query = `
    INSERT INTO Booking (RoomID, CustomerID, EmployeeID, StartDate, EndDate) 
    VALUES 
    ($1, (SELECT CustomerID FROM Customer WHERE FullName = $2), $3, $4, $5)
  `;

  try {
    await pool.query(query, [roomId, customerFullName, employeeId, startDate, endDate]);
    res.status(201).send('Booking created successfully');
  } catch (err) {
    console.error('Error creating booking', err);
    res.status(500).send('Failed to create booking');
  }
});

//get all employees
app.get("/employees", async (req, res) => {
  try {
    const data = await pool.query(`
      SELECT * FROM employee
      ORDER BY employeeid ASC 
    `);
    res.json(data.rows);
  } catch (err) {
    console.error("Database query error:", err.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

//get hotel
app.get("/hotel/:hotelId", async (req, res) => {
  try {
    let query = `SELECT * FROM hotel WHERE hotelid = ${req.params.hotelId}`;
    const allRooms = await pool.query(query);
    res.json(allRooms.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

// Get all hotels or filter by location, chain, or rating
app.get("/hotels", async (req, res) => {
  try {
    let query = `SELECT * FROM hotel`;

    // Check if location parameter is provided
    if (req.query.location) {
      const location = req.query.location;
      query += ` WHERE Address LIKE '%${location}%'`;
    }

    if (req.query.chain) {
      const chain = req.query.chain;
      // Correctly append with 'AND' and use '=' for equality check
      if (query.includes("WHERE")) {
        query += ` AND ChainID = '${chain}'`; // Assuming ChainID is a string; use without quotes if it's a numeric type
      } else {
        query += ` WHERE ChainID = '${chain}'`;
      }
    }    

    // Check if rating parameter is provided
    if (req.query.rating) {
      const rating = req.query.rating;
      if (query.includes("WHERE")) {
        query += ` AND Rating = ${rating}`;
      } else {
        query += ` WHERE Rating = ${rating}`;
      }
    }

    query += ` ORDER BY hotelid ASC;`;

    const allHotels = await pool.query(query);
    res.json(allHotels.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

//get all rooms for hotel
app.get("/hotel-rooms/:hotelId", async (req, res) => {
  try {
    const { start_date, end_date } = req.query;
    let query = `
      SELECT r.* FROM room r
      WHERE r.hotelid = $1`;

    let queryParams = [req.params.hotelId];

    // If both start_date and end_date are provided
    if (start_date && end_date) {
      query += `
        AND r.roomid NOT IN (
          SELECT b.roomid FROM booking b
          WHERE b.startdate <= $3 AND b.enddate >= $2
        )`;
      queryParams.push(start_date, end_date);
    }
    // If only start_date is provided
    else if (start_date) {
      query += `
        AND r.roomid NOT IN (
          SELECT b.roomid FROM booking b
          WHERE b.enddate >= $2
        )`;
      queryParams.push(start_date);
    }
    // If only end_date is provided
    else if (end_date) {
      query += `
        AND r.roomid NOT IN (
          SELECT b.roomid FROM booking b
          WHERE b.startdate <= $2
        )`;
      queryParams.push(end_date);
    }

    const allRooms = await pool.query(query, queryParams);
    res.json(allRooms.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});


//get number of hotels in each hotel chain
app.get("/chain-hotels", async (req, res) => {
  try {
    const data = await pool.query(`
        SELECT ChainID, COUNT(*) AS NumberOfHotels FROM Hotel GROUP BY ChainID;
      `);
    res.json(data.rows);
  } catch (err) {
    console.error("Database query error:", err.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

//get all the hotels that have a higher number of rooms than the average number of room per hotel in the database
app.get("/room-avg-high", async (req, res) => {
  try {
    const data = await pool.query(`
      SELECT * FROM Hotel WHERE NumberOfRooms > (SELECT AVG(NumberOfRooms) FROM Hotel);
      `);
    res.json(data.rows);
  } catch (err) {
    console.error("Database query error:", err.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.listen(5000, () => {
  console.log("Server is starting on port 5000");
});
