# Tokenized Asset Management Tracking and Maintenance System

A comprehensive blockchain-based asset management system built with Clarity smart contracts for the Stacks blockchain. This system provides end-to-end asset lifecycle management with tokenization capabilities.

## 🚀 Features

### Core Components

1. **Asset Manager Verification** - Validates and manages asset management companies
2. **Asset Tracking** - Comprehensive asset registration and tracking with tokenization
3. **Maintenance Scheduling** - Automated maintenance scheduling and tracking
4. **Depreciation Calculation** - Multiple depreciation methods with automated calculations
5. **Lifecycle Management** - Complete asset lifecycle from acquisition to disposal

### Key Capabilities

- ✅ **Manager Verification**: Validate asset management companies with licensing
- ✅ **Asset Tokenization**: Convert physical assets into blockchain tokens
- ✅ **Real-time Tracking**: Monitor asset location, value, and status
- ✅ **Automated Maintenance**: Schedule and track maintenance activities
- ✅ **Depreciation Management**: Calculate asset depreciation using multiple methods
- ✅ **Lifecycle Tracking**: Manage complete asset lifecycle stages
- ✅ **Audit Trail**: Immutable record of all asset transactions and changes
- ✅ **Access Control**: Role-based permissions for different user types

## 📋 Prerequisites

- Stacks blockchain node or access to testnet/mainnet
- Clarity CLI for contract deployment
- Node.js 18+ for running tests
- Vitest for testing framework

## 🛠️ Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd tokenized-asset-management
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## 📁 Project Structure

\`\`\`
tokenized-asset-management/
├── contracts/
│   ├── asset-manager-verification.clar
│   ├── asset-tracking.clar
│   ├── maintenance-scheduling.clar
│   ├── depreciation-calculation.clar
│   └── lifecycle-management.clar
├── tests/
│   ├── asset-manager-verification.test.js
│   ├── asset-tracking.test.js
│   ├── maintenance-scheduling.test.js
│   ├── depreciation-calculation.test.js
│   └── lifecycle-management.test.js
├── README.md
└── PR-DETAILS.md
\`\`\`

## 🔧 Contract Deployment

Deploy contracts in the following order to ensure proper dependencies:

1. **Asset Manager Verification**
   \`\`\`bash
   clarinet deploy contracts/asset-manager-verification.clar
   \`\`\`

2. **Asset Tracking**
   \`\`\`bash
   clarinet deploy contracts/asset-tracking.clar
   \`\`\`

3. **Maintenance Scheduling**
   \`\`\`bash
   clarinet deploy contracts/maintenance-scheduling.clar
   \`\`\`

4. **Depreciation Calculation**
   \`\`\`bash
   clarinet deploy contracts/depreciation-calculation.clar
   \`\`\`

5. **Lifecycle Management**
   \`\`\`bash
   clarinet deploy contracts/lifecycle-management.clar
   \`\`\`

## 💼 Usage Examples

### Verify Asset Manager

\`\`\`clarity
(contract-call? .asset-manager-verification verify-manager
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
"ABC Asset Management"
"AM123456")
\`\`\`

### Register New Asset

\`\`\`clarity
(contract-call? .asset-tracking register-asset
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
"Equipment"
"Industrial Generator"
u50000
"Warehouse A")
\`\`\`

### Schedule Maintenance

\`\`\`clarity
(contract-call? .maintenance-scheduling schedule-maintenance
u1
"Preventive"
u2000
u500
"high")
\`\`\`

### Set Depreciation Parameters

\`\`\`clarity
(contract-call? .depreciation-calculation set-depreciation-parameters
u1
"straight-line"
u10
u5000)
\`\`\`

### Initialize Asset Lifecycle

\`\`\`clarity
(contract-call? .lifecycle-management initialize-lifecycle
u1
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
u5000)
\`\`\`

## 🧪 Testing

The project includes comprehensive tests for all contracts:

\`\`\`bash
# Run all tests
npm test

# Run specific test file
npm test asset-tracking.test.js

# Run tests with coverage
npm run test:coverage
\`\`\`

## 🔐 Security Features

- **Access Control**: Role-based permissions for different operations
- **Input Validation**: Comprehensive validation of all inputs
- **Error Handling**: Proper error codes and messages
- **Audit Trail**: Immutable record of all transactions
- **State Management**: Consistent state across all contracts

## 📊 Asset Lifecycle Stages

1. **Planning** - Initial asset planning phase
2. **Acquisition** - Asset purchase and onboarding
3. **Deployment** - Asset deployment and setup
4. **Operation** - Active operational phase
5. **Maintenance** - Maintenance and repair activities
6. **Retirement** - End-of-life preparation
7. **Disposal** - Final disposal and record closure

## 🔄 Depreciation Methods

- **Straight-Line**: Equal depreciation over useful life
- **Declining Balance**: Accelerated depreciation method
- **Custom Rates**: Configurable depreciation rates

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the documentation
- Review the test files for usage examples

## 🔮 Future Enhancements

- Integration with IoT devices for real-time asset monitoring
- Advanced analytics and reporting features
- Mobile application for field asset management
- Integration with external ERP systems
- Multi-signature support for high-value assets
- Automated compliance reporting
