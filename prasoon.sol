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

    // Deposit ETH
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw ETH
    function withdraw(uint amount) external onlyOwner {
        require(address(this).balance >= amount, "Not enough balance");
        payable(owner).transfer(amount);

        emit Withdraw(owner, amount);
    }

    // Send ETH to another address
    function sendTo(address payable to, uint amount) external onlyOwner {
        require(address(this).balance >= amount, "
    // Check wallet balance
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}

Insufficient balance");
        to.transfer(amount);

        emit TransferSent(msg.sender, to, amount);
    }

    // Check wallet balance
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
