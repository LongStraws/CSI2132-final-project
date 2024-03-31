const Pool = require("pg").Pool

const pool = new Pool({
    user: "postgres",
    password: "4900123",
    database: "ehotels",
    host: "localhost",
    port: 5432,
});

module.exports = pool;