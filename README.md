DBMS: PostgreSQL
Programming languages: JavaScript, TypeScript, react, node.js, HTML, CSS

Installation guide (must have Node.js installed, with Postgres):

- Navigate to the project directory
- In each sub-directory (client and server) run the command `npm install`
- To start the client web app, run `npm run dev`
- In the server directory, make a file called `db.js`
- In the `db.js` file, add the following code to establish a connection to the PostgreSQL database:

```javascript
const { Pool } = require("pg");
const pool = new Pool({
  user: "your_username",
  host: "your_host",
  database: "your_database",
  password: "your_password",
  port: "your_port",
});

module.exports = pool;
```

- Copy and paste the `database.sql`, and import it into Postgres, or copy-paste into the command line
- Navigate to the server directory and run `node index.js` to start the server
- You're ready to start using the application!
