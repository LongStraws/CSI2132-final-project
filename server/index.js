const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");

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

//get all bookings
app.get("/bookings", async (req, res) => {
  try {
    let query = `SELECT * FROM booking 
                 ORDER BY bookingid ASC`
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
    console.log(query)
    const viewData = await pool.query(query);
    res.json(viewData.rows);
  } catch (err) {
    console.error("Database query error:", err.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Get all hotels or filter by location
app.get("/hotels", async (req, res) => {
    try {
      let query = `SELECT * FROM hotel`;
  
      // Check if location parameter is provided
      if (req.query.location) {
        const location = req.query.location;
        query += ` WHERE Address LIKE '%${location}%'`;
      }
  
      query += ` ORDER BY hotelid ASC;`;
  
      const allHotels = await pool.query(query);
      res.json(allHotels.rows);
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
