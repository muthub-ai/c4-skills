const express = require('express');
const { getAccounts } = require('./services/AccountService');

// API Application container for the Internet Banking System
// Technology: JavaScript, Express/Node.js
const app = express();

app.get('/api/accounts', async (req, res) => {
  // Makes internal service calls
  const accounts = await getAccounts(req.user?.id || 1);
  res.json(accounts);
});

// Sends e-mail using SMTP to E-mail System (External)
app.post('/api/contact', (req, res) => {
  console.log("Sending email via SMTP to Exchange server...");
  res.send("Email sent");
});

app.listen(3000, () => console.log('API listening on port 3000'));
