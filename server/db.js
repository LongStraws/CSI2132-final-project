const Pool = require("pg").Pool;

const pool = new Pool({
  user: "yahyaosman",
  password: "EncryptionKey1",
  database: "ehotels",
  host: "localhost",
  port: 5432,
});

module.exports = pool;
