# Internet Banking System

This is a mock repository designed specifically to test AI coding agents' ability to generate C4 architecture diagrams and Architecture Decision Records (ADRs).

## Architecture Overview
- **Frontend**: A React-based Single Page Application (SPA).
- **Backend API**: A Node.js/Express REST API.
- **Database**: PostgreSQL 15 (chosen over MongoDB for strict ACID compliance).
- **External Dependencies**: The API communicates with an external Microsoft Exchange E-mail System via SMTP to send notifications.

## Running locally
```bash
docker-compose up
```
