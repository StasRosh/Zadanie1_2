const express = require('express');
const app = express();
const os = require('os');
const port = process.env.PORT || 8080;

// Funkcja zwracająca adres IP serwera
function getIPAddress() {
  const interfaces = os.networkInterfaces();
  for (const key in interfaces) {
    for (const iface of interfaces[key]) {
      if (!iface.internal && iface.family === 'IPv4') {
        return iface.address;
      }
    }
  }
  return '127.0.0.1';
}

app.get('/', (req, res) => {
  // Pobranie adresu IP serwera
  const ipAddress = getIPAddress();
  // Pobranie nazwy serwera (hostname)
  const hostname = os.hostname();
  // Pobranie wersji aplikacji
  const version = process.env.APP_VERSION || '1.0.0';
  
  // Zwrócenie odpowiedzi zawierającej informacje
  res.send(`IP severa: ${ipAddress}<br>Hostname: ${hostname}<br>Version: ${version}`);
});

app.listen(port, () => {
  console.log(`Server dziala na porcie:  ${port}`);
});
