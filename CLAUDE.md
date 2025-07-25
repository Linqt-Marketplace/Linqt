# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Internet Computer (ICP) escrow application built with Rust canisters. The project uses the DFX framework for canister development and deployment.

## Architecture

- **Workspace Structure**: Cargo workspace with a single backend canister
- **Backend Canister**: `eascrow_icp_backend` - Rust canister using ic-cdk
- **Interface**: Candid (.did) files define the canister's public API
- **Build Target**: WebAssembly (cdylib) for deployment to Internet Computer

## Development Commands

### Local Development
```bash
# Start local replica in background
dfx start --background

# Deploy canisters locally
dfx deploy

# Generate Candid interface (after backend changes)
npm run generate

# Start frontend development server (if frontend exists)
npm start
```

### DFX Commands
```bash
# Get help with DFX
dfx help
dfx canister --help

# Stop local replica
dfx stop
```

### Cargo Commands
```bash
# Build Rust code
cargo build

# Run tests
cargo test

# Check code without building
cargo check
```

## File Structure

- `dfx.json` - DFX configuration defining canisters
- `Cargo.toml` - Workspace configuration
- `src/eascrow_icp_backend/` - Backend canister source
  - `Cargo.toml` - Canister-specific dependencies
  - `eascrow_icp_backend.did` - Candid interface definition
  - `src/lib.rs` - Main canister implementation

## Key Dependencies

- `ic-cdk` - Internet Computer Canister Development Kit
- `candid` - Interface description language for ICP
- `ic-cdk-timers` - Timer functionality (optional)

## Development Notes

- Canisters compile to WebAssembly (`cdylib` crate type)
- Use `dfx deploy` to deploy changes to local replica
- The local application runs at `http://localhost:4943?canisterId={asset_canister_id}`
- Frontend development server (if present) runs at `http://localhost:8080`