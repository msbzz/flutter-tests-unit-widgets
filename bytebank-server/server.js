const express = require('express');
const app = express();
const port = 8080;

app.use(express.json());

let transactions = [];  // Base de dados em memória

// Endpoint para obter todas as transações
app.get('/transactions', (req, res) => {
  console.log('Fetching transactions:', transactions);  // Log para depuração
  res.json(transactions);
});

// Endpoint para salvar uma nova transação
app.post('/transactions', (req, res) => {
  const transaction = req.body;
  transactions.push(transaction);
  console.log('Added transaction:', transaction);  // Log para depuração
  res.status(201).json(transaction);
});

// Endpoint para resetar a base de dados
app.post('/reset', (req, res) => {
  console.log('Resetting database...');  // Log antes do reset
  transactions = [];
  console.log('Database reset, transactions:', transactions);  // Log após o reset
  res.status(200).send('Database reset');
});

// Endpoint para deletar uma transação específica
app.delete('/transactions/:id', (req, res) => {
    const id = req.params.id;
    const initialLength = transactions.length;
    transactions = transactions.filter(transaction => transaction.id !== id);
    if (transactions.length < initialLength) {
      console.log(`Deleted transaction with id: ${id}`);  // Log para depuração
      res.status(200).send(`Transaction with id ${id} deleted`);
    } else {
      console.log(`Transaction with id ${id} not found`);  // Log para depuração
      res.status(404).send(`Transaction with id ${id} not found`);
    }
  });

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});
