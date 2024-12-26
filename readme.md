# Decentralized Polls 🗳️

## Project Overview

Decentralized Polls is a blockchain-based voting platform that allows users to create and participate in transparent, tamper-proof polls using Ethereum smart contracts.

## Features

### Smart Contract Capabilities
- Create polls with multiple options
- Set poll duration
- Cast votes securely
- Prevent duplicate voting
- Track real-time voting results

### Frontend Functionality
- Create new polls
- View active polls
- Vote on polls
- Dynamic vote counting
- Responsive design

## Technology Stack

### Backend
- Solidity
- Ethereum Blockchain
- Smart Contract Development

### Frontend
- HTML5
- CSS3
- JavaScript
- Web3.js
- MetaMask Integration

## Prerequisites

- [MetaMask](https://metamask.io/) Browser Extension
- Ethereum-compatible Browser
- Web3 Wallet
- Solidity Development Environment

## Installation

### Smart Contract Deployment
1. Install [Hardhat](https://hardhat.org/) or [Truffle](https://www.trufflesuite.com/truffle)
2. Compile the contract
3. Deploy to desired Ethereum network

### Frontend Setup
1. Clone the repository
2. Replace contract ABI in `index.html`
3. Add deployed contract address
4. Open `index.html` in a Web3-compatible browser

## Smart Contract Functions

### `createPoll()`
- Creates a new poll
- Requires:
  - Poll question
  - Minimum 2 options
  - Poll duration

### `vote()`
- Cast a vote on an active poll
- Prevents:
  - Multiple voting
  - Voting on inactive polls

### `getPollInfo()`
- Retrieves complete poll information
- Returns:
  - Poll question
  - Options
  - Vote counts
  - Start and end times

## Security Features

- Modular access control
- Time-based poll activation
- Vote duplicate prevention
- Transparent voting mechanism

## Workflow

1. Connect MetaMask Wallet
2. Create a Poll
3. Set Poll Duration
4. Add Poll Options
5. Users Can Vote
6. View Real-time Results

## Potential Improvements

- Implement vote weight mechanisms
- Add more advanced voting strategies
- Create voter authentication
- Develop result visualization

## Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create pull request

## Disclaimer

- Use at your own risk
- Not audited for production use
- Experimental blockchain application
