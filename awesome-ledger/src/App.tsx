import React, { useEffect, useState } from 'react';
import { ethers } from 'ethers';
import TokenArtifact from './config/contracts/DemezyToken.json';

const tokenAddress = '0x2879332E29FcD51478d2e8072F0E1f31537D8c76';
const provider = new ethers.JsonRpcProvider();

function App() {
  const [balance, setBalance] = useState(0);
  const [transferAmount, setTransferAmount] = useState(0);
  const [users, setUsers] = useState<string[]>([]);
  const [selectedUser, setSelectedUser] = useState('');

  async function fetchBalance() {
    const contract = new ethers.Contract(tokenAddress, TokenArtifact.abi, provider);
    const balance = await contract.balanceOf(selectedUser);
    setBalance(balance.toNumber());
  }

  async function fetchUsers() {
    const contract = new ethers.Contract(tokenAddress, TokenArtifact.abi, provider);
    const totalSupply = await contract.totalSupply();
    const users = [];
    for (let i = 0; i < totalSupply; i++) {
      const address = await contract.ownerOf(i);
      users.push(address);
    }
    setUsers(users);
  }

  // useEffect(() => {
  //   fetchBalance();
  //   fetchUsers();
  // }, [
  //   fetchBalance(),
  //   fetchUsers(),
  // ]);

  async function transferTokens(to: string, amount: number) {
    try {
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(tokenAddress, TokenArtifact.abi, signer);
      const transaction = await contract.transfer(to, amount);
      await transaction.wait();
      fetchBalance();
      fetchUsers();
    } catch (error) {
      console.error('Error transferring tokens:', error);
    }

  }

  return (
    <div>
      <h1>Token Transfer</h1>
      <div>
        <h3>Balances:</h3>
        <p>Selected User: {selectedUser}</p>
        <p>Balance: {balance}</p>
      </div>
      <div>
        <h3>Users:</h3>
        <ul>
          {users.map((user) => (
            <li key={user}>{user}</li>
          ))}
        </ul>
      </div>
      <div>
        <h3>Transfer Tokens:</h3>
        <input
          type="text"
          placeholder="Recipient Address"
          value={selectedUser}
          onChange={(e) => setSelectedUser(e.target.value)}
        />
        <input
          type="number"
          placeholder="Amount"
          onChange={(e) => setTransferAmount(parseInt(e.target.value))}
        />
        <button onClick={() => transferTokens(selectedUser, transferAmount)}>Transfer</button>
      </div>
    </div>
  );
}

export default App;
