import React, { useState, useEffect } from 'react';

// Single-Page App container for the Internet Banking System
// Technology: JavaScript, React
function App() {
  const [accounts, setAccounts] = useState([]);

  useEffect(() => {
    // Makes API calls to API Application via JSON/HTTPS
    fetch('/api/accounts')
      .then(res => res.json())
      .then(data => setAccounts(data));
  }, []);

  return (
    <div>
      <h1>Internet Banking System</h1>
      <h2>Your Accounts</h2>
      <ul>
        {accounts.map(acc => (
          <li key={acc.id}>{acc.name}: ${acc.balance}</li>
        ))}
      </ul>
      <button onClick={() => alert('Sending payment...')}>Make Payment</button>
    </div>
  );
}

export default App;
