const { Client } = require('pg');

// AccountService Component
// Technology: JavaScript, Node.js
async function getAccounts(userId) {
  // Reads from and writes to Database via JDBC (using pg here as JS equivalent)
  const client = new Client({
    host: 'db',
    port: 5432,
    database: 'banking',
  });
  
  await client.connect();
  const res = await client.query('SELECT * FROM accounts WHERE user_id = $1', [userId]);
  await client.end();
  
  return res.rows;
}

module.exports = { getAccounts };
