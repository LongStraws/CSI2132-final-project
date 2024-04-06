DBMS : PostgreSQL
Programming languages: JavaScript, TypeScript, react, nodejs, HTML, CSS

Installation guide (must have Node.js installed, with postgres):
-> Navigate to project directory
-> In each sub directory (client and server) run command npm install
-> To start client web app, run npm run dev
-> In server directory, make a file called db.js
-> In the `db.js` file, add the following code to establish a connection to the PostgreSQL database:
const { Pool } = require('pg');

```
    const pool = new Pool({
    user: 'your_username',
    host: 'your_host',
    database: 'your_database',
    password: 'your_password',
    port: 'your_port',
    });

    module.exports = pool;
```

-> Copy paste the database.sql, and import into postgres, or copy paste into the command line
-> Navigate to the server directory and run node index.js to start the server
-> You're ready to start using the application!
