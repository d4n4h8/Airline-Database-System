# ✈️ Airline Reservation System (SQL Database Design)

A relational database project focused on designing, modeling, and implementing a robust **Airline Reservation System** using MySQL. The system effectively manages core aviation operations including airlines, aircraft fleet capacities, flight scheduling, passenger demographics, and real-time ticketing/booking status.

---

### ⚙️ Core Features & Database Lifecycle
1. **Conceptual Design (ER Modeling):** Structured an Entity-Relationship Diagram (ERD) defining entities, primary/foreign keys, and cardinalities.
2. **Logical Design (Relational Schema):** Mapped the ERD into normalized relational tables enforcing referential integrity.
3. **Data Definition (DDL):** Implemented MySQL tables with strict constraints (`PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `CHECK`).
4. **Data Manipulation (DML):** Populated the schema with realistic aviation datasets and transactions.
5. **Data Analysis & Reporting:** Developed analytical SQL queries utilizing aggregations (`GROUP BY`), multi-table `JOIN` operations, conditional filtering, and Subqueries.
6. **Database Views:** Created virtual summary tables for automated business reports.

---

### 🗄️ Relational Architecture & Entities
The system architecture consists of **6 primary tables** designed to optimize data consistency and prevent redundancy:
* 🏢 **Airline:** Tracks global carrier information.
* 🛩️ **Airplane:** Manages fleet metrics and seating capacities.
* 📅 **Flight:** Controls route planning, schedules, and pricing.
* 🕒 **Flight_Status:** Captures live status updates (Scheduled, Delayed, Cancelled).
* 👤 **Passenger:** Stores customer records, contacts, and demographics.
* 🎫 **Booking:** Records ticket reservations, seat assignments, and travel classes.

---

### 🛠️ Technologies Used
<p align="left">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Database%20Design-Structured%20Query%20Language-orange?style=flat" alt="SQL">
</p>

---

### 🖼️ Schema & Conceptual Layout

#### 🗺️ Entity-Relationship Diagram (ERD)
![ERD](ER%20Diagram.png)

#### 📋 Relational Database Schema
![Schema](Relational%20Schema.png)

---

---

### 💻 Local Implementation & Setup
To deploy this database script locally on your MySQL instance, follow these steps:

1. **Clone this repository to your machine:**
   ```bash
   git clone [https://github.com/d4n4h8/Airline-Database-System.git](https://github.com/d4n4h8/Airline-Database-System.git)
