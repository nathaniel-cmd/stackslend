# Stacks Lend DeFi Protocol

A sophisticated DeFi lending protocol built on Stacks Layer 2 that enables secure STX collateralized borrowing with dynamic risk management and automated liquidation mechanisms for the Bitcoin ecosystem.

## Overview

Stacks Lend revolutionizes Bitcoin DeFi by providing a trustless lending infrastructure where users can deposit STX as collateral to borrow against their holdings. The protocol features adaptive collateral ratios, real-time position monitoring, and permissionless liquidations to maintain system stability. Built with enterprise-grade security and compliance for institutional adoption on Bitcoin's most robust Layer 2 solution.

## System Architecture

### Core Components

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   User Interface│    │  Smart Contract │    │  Risk Engine    │
│                 │    │                 │    │                 │
│ • Deposit       │◄──►│ • Collateral    │◄──►│ • Health Ratio  │
│ • Borrow        │    │   Management    │    │ • Liquidation   │
│ • Repay         │    │ • Loan Tracking │    │   Threshold     │
│ • Withdraw      │    │ • Interest Calc │    │ • Protocol Fees │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Contract Architecture

The protocol is structured around several key modules:

#### 1. **Core Protocol Operations**

- **Deposit**: Users deposit STX as collateral
- **Borrow**: Borrow STX against deposited collateral
- **Repay**: Repay borrowed STX to reduce debt
- **Withdraw**: Withdraw excess collateral (maintaining minimum ratios)

#### 2. **Risk Management System**

- **Collateral Ratios**: Dynamic ratio calculations for position health
- **Liquidation Engine**: Automated liquidation of undercollateralized positions
- **Interest Calculations**: Time-based interest accrual on borrowed amounts

#### 3. **Data Management**

- **Position Tracking**: Individual user portfolio management
- **Protocol Metrics**: Global statistics and health monitoring
- **Administrative Controls**: Parameter adjustment capabilities

## Data Flow

### Lending Flow

```
User Deposits STX → Collateral Recorded → Borrowing Power Calculated → 
User Borrows STX → Debt Position Created → Interest Begins Accruing
```

### Liquidation Flow

```
Position Monitoring → Health Ratio < Threshold → Liquidation Triggered → 
Collateral Seized → Debt Cleared → Position Removed
```

## Key Features

### 🔒 **Secure Collateralization**

- Minimum collateral ratio: 150% (configurable)
- Liquidation threshold: 130% (configurable)
- Real-time position monitoring

### ⚡ **Dynamic Risk Management**

- Automated liquidation system
- Configurable risk parameters
- Interest rate calculations

### 📊 **Position Tracking**

- Individual user portfolios
- Global protocol statistics
- Comprehensive health metrics

### 🛡️ **Enterprise Security**

- Administrative controls
- Parameter validation
- Error handling system

## Protocol Parameters

| Parameter | Default Value | Range | Description |
|-----------|---------------|-------|-------------|
| Minimum Collateral Ratio | 150% | 110%-500% | Required collateral vs debt ratio |
| Liquidation Threshold | 130% | 110%-MCR | Health ratio triggering liquidation |
| Protocol Fee | 1% | 0%-10% | Fee charged on protocol operations |

## Smart Contract Functions

### Public Functions

#### Core Operations

- `deposit()` - Deposit STX as collateral
- `borrow(amount)` - Borrow STX against collateral
- `repay(amount)` - Repay borrowed STX
- `withdraw(amount)` - Withdraw collateral

#### Liquidation

- `liquidate(user)` - Liquidate undercollateralized position

#### Administration

- `set-minimum-collateral-ratio(ratio)` - Update minimum collateral requirements
- `set-liquidation-threshold(threshold)` - Update liquidation parameters
- `set-protocol-fee(fee)` - Update protocol fee structure

### Read-Only Functions

- `get-user-position(user)` - Retrieve user's position data
- `get-protocol-stats()` - Get global protocol statistics

## Usage Examples

### Depositing Collateral

```clarity
;; User deposits their STX balance as collateral
(contract-call? .Stacks Lend deposit)
```

### Borrowing Against Collateral

```clarity
;; Borrow 1000 STX (must maintain minimum collateral ratio)
(contract-call? .Stacks Lend borrow u1000)
```

### Repaying Debt

```clarity
;; Repay 500 STX to reduce debt position
(contract-call? .Stacks Lend repay u500)
```

### Checking Position Health

```clarity
;; View user's position details
(contract-call? .Stacks Lend get-user-position 'SP1234...)
```

## Risk Considerations

### For Users

- **Liquidation Risk**: Positions below 130% collateral ratio face liquidation
- **Interest Accrual**: Borrowed amounts accrue interest over time
- **Collateral Requirements**: Minimum 150% collateralization required

### For the Protocol

- **Smart Contract Risk**: Code vulnerabilities could affect user funds
- **Oracle Dependency**: Price feeds critical for accurate liquidations
- **Governance Risk**: Administrative parameter changes affect protocol behavior

## Error Codes

| Code | Error | Description |
|------|-------|-------------|
| u100 | ERR-NOT-AUTHORIZED | Unauthorized access attempt |
| u101 | ERR-INSUFFICIENT-COLLATERAL | Inadequate collateral for operation |
| u102 | ERR-INVALID-AMOUNT | Invalid amount specified |
| u103 | ERR-LOAN-NOT-FOUND | Loan record not found |
| u104 | ERR-LOAN-ACTIVE | Cannot modify active loan |
| u105 | ERR-INSUFFICIENT-BALANCE | Insufficient balance for operation |
| u106 | ERR-LIQUIDATION-FAILED | Liquidation conditions not met |
| u107 | ERR-INVALID-PARAMETER | Invalid parameter value |

## Development

### Prerequisites

- Stacks CLI
- Clarinet for testing
- Node.js for tooling

### Testing

```bash
clarinet test
```

### Deployment

```bash
clarinet deploy --network testnet
```

## Security Audits

This protocol should undergo comprehensive security audits before mainnet deployment. Key areas for review:

- Collateral ratio calculations
- Liquidation mechanism integrity
- Interest calculation accuracy
- Administrative controls security

## Contributing

1. Fork the repository
2. Create a feature branch
3. Implement changes with tests
4. Submit pull request with detailed description
