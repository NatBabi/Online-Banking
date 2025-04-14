# Project Requirements Document (PRD)

## Overview

This document outlines the functional requirements for the **Online Banking System**. It compares the **implemented features** with the **planned features** based on the available codebase.

---

## Functional Requirements vs. Implementation

### 1. **User Registration and Authentication**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR001 | User Authentication            | As a user, I want to register and authenticate using my ASTU credentials to access the system.      | System should allow users to register and authenticate with their credentials. | ✅ Implemented | LoginServlet, User authentication integrated, but no E-student System integration found. |

---

### 2. **Account Overview**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR002 | Account Overview               | As a user, I want to view a summary of my account balances and recent activities.                 | The system should display the user’s balance and transaction history.    | ❌ Not Implemented | No servlet or page for displaying detailed account information. |

---

### 3. **Fund Transfer**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR003 | Fund Transfer                  | As a user, I want to transfer funds to another user.                                                | The system should facilitate transferring funds between users.           | ✅ Implemented | moneyTransfer.java handles transfer functionality. |

---

### 4. **Payment Management**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR004 | Payment Management             | As a user, I want to make various payments such as tuition, fees, and other services.               | The system should support processing payments for various campus services. | ✅ Implemented | registrarPaymentServlet.java handles payments for registrar. |

---

### 5. **Transaction History**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR005 | Transaction History            | As a user, I want to view my transaction history and filter/search by date or type.                | The system should display transactions with filtering and search options. | ❌ Not Implemented | No dedicated feature for transaction history filtering/searching. |

---

### 6. **Account Management**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR006 | Account Management             | As a user, I want to update my personal account information.                                        | Users should be able to modify personal details such as address, phone number, etc. | ❌ Not Implemented | No user profile edit functionality found in current codebase. |

---

### 7. **Loan and Advance Management**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR007 | Loan Application               | As a user, I want to apply for a loan or advance.                                                  | The system should allow loan requests to be submitted.                   | ✅ Implemented | loanRequest.java implements loan application. |
| FR008 | Loan Application Review        | As an admin, I want to review, approve, or reject loan requests.                                   | Admins can view and process loan requests.                               | ✅ Implemented | The loan review process is implied in code, but admin management tools are not present. |
| FR009 | Loan Repayment Tracking        | As a user, I want to make loan repayments.                                                         | Users should be able to track and make loan repayments.                  | ✅ Implemented | loanPaymentServlet.java handles loan repayment functionality. |

---

### 8. **User Account Management (Admin)**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR010 | Admin User Management          | As an admin, I want to manage user accounts (create, edit, delete).                                | Admins should be able to manage user roles, permissions, and account details. | ❌ Not Implemented | No admin interface for user management found. |

---

### 9. **Payroll and Retirement Management**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR011 | Payroll Management             | As a staff member, I want to view and manage my salary details and deductions.                      | Users should be able to access salary details, deductions, and summaries. | ❌ Not Implemented | No payroll-related functionality found in the current codebase. |

---

### 10. **Customer Support Integration**

| ID    | Feature                        | User Story                                                                                          | Expected Behavior / Outcome                                              | Status     | Notes                                                                                 |
|-------|--------------------------------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|------------|---------------------------------------------------------------------------------------|
| FR012 | Customer Support               | As a user, I want access to a help center and contact support for banking issues.                   | The system should provide resources and support options for users.      | ❌ Not Implemented | No customer support functionality found in the current codebase. |

---

## Summary

### **Implemented Features**
- User Authentication
- Fund Transfer
- Payment Management
- Loan Application and Repayment
- Admin User Management (Partially)

### **Features to be Implemented**
- Full Account Overview
- Transaction History and Filtering
- User Profile Management
- Full Admin User Management
- Payroll and Retirement Management
- Customer Support Integration

---

## Action Plan

- **Integration of E-student System**: Collaborate with the student management system to enable registration.
- **Transaction History**: Implement history display and filtering functionality.
- **User Account Management**: Add functionalities for updating personal info and profile management.
- **Admin Panel Development**: Complete the admin interface for account management, role assignments, and user permissions.
- **Payroll & Retirement**: Implement payroll calculation and retirement management.
- **Customer Support**: Implement a simple FAQ page and contact support system for users.

---

