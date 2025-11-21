# 🚀 PrasoonWallet — My First Blockchain Smart Contract

**PrasoonWallet** is a secure, owner-controlled Ethereum wallet written in Solidity.  
It allows depositing, withdrawing, and transferring Ether using pure blockchain logic — with no third-party control.

This is my **first fully working blockchain project**, built and deployed using Remix IDE.

---

## 🌟 Features

### ✔ Owner-Based Wallet  
Only the contract deployer (owner) can withdraw or transfer ETH.

### ✔ Receive ETH Directly  
The wallet automatically accepts Ether using Solidity’s `receive()` function.

### ✔ Secure Withdrawals  
The owner can safely withdraw ETH back to their own account.

### ✔ Transfer ETH to Any Address  
Send ETH from the contract to any external wallet.

### ✔ Event Logging  
Emits events for every major action:
- `Deposit`
- `Withdraw`
- `TransferSent`

### ✔ View Contract Balance  
Check the ETH balance stored inside the smart contract.

---

## 🛠️ Smart Contract Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PrasoonWallet {
    address public owner;

    event Deposit(address indexed from, uint amount);
    event Withdraw(address indexed to, uint amount);
    event TransferSent(address indexed from, address indexed to, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) external onlyOwner {
        require(address(this).balance >= amount, "Not enough balance");
        payable(owner).transfer(amount);
        emit Withdraw(owner, amount);
    }

    function sendTo(address payable to, uint amount) external onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance");
        to.transfer(amount);
        emit TransferSent(msg.sender, to, amount);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
