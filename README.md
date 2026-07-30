# Oracle SQL and PL/SQL Car Dealership Database

This project contains an Oracle database designed for managing a second-hand car dealership. It stores information about vehicles, clients, employees, suppliers, sales and available stock.

The project includes both SQL and PL/SQL components. The SQL section covers schema creation, sample data, data manipulation, queries and database objects. The PL/SQL section contains control structures, cursors, exception handling, procedures, functions, packages and triggers.

This project was developed as part of a university assignment.

## Project Purpose

The purpose of the project is to demonstrate the design and implementation of a relational database in Oracle, followed by the use of PL/SQL to add procedural logic and reusable database objects.

## Main Features

- Management of vehicles, clients, employees, suppliers, sales and stock
- Primary and foreign key relationships between the main entities
- Constraints for prices, salaries, stock quantities and vehicle availability
- Fictional sample data for testing
- SQL queries using joins, subqueries, grouping, aggregate functions, `CASE`, `DECODE`, `UNION`, `INTERSECT` and `MINUS`
- A database view, index, sequence and optional synonym
- PL/SQL control structures and explicit and implicit cursors
- Predefined, Oracle and user-defined exception handling
- Stored procedures and functions
- PL/SQL packages
- Triggers for validation and automatic messages

## Technologies Used

- Oracle Database
- Oracle SQL
- PL/SQL
- Oracle APEX SQL Workshop
- Oracle SQL Developer

## Database Structure

| Table | Purpose |
| --- | --- |
| `Vehicule` | Stores vehicle information, prices, availability and suppliers |
| `Clienti` | Stores fictional client information |
| `Angajati` | Stores employees, roles and salaries |
| `Furnizori` | Stores vehicle supplier information |
| `Vanzari` | Records vehicle sales and the associated clients and employees |
| `Stocuri` | Stores the vehicles currently available in stock |

## Project Structure

```text
Oracle-Sql-Plsql-Car-Dealership
├── sql/
│   ├── 01-schema.sql
│   ├── 02-sample-data.sql
│   ├── 03-data-updates.sql
│   ├── 04-queries.sql
│   ├── 05-database-objects.sql
│   └── 06-flashback-example.sql
├── plsql/
│   ├── 01-control-structures.sql
│   ├── 02-cursors.sql
│   ├── 03-exceptions.sql
│   ├── 04-procedures.sql
│   ├── 05-functions.sql
│   ├── 06-packages.sql
│   ├── 07-triggers.sql
│   └── 08-usage-examples.sql
├── apex-install.sql
├── apex-verification.sql
├── run-project.sql
├── .gitignore
└── README.md
```

## Prerequisites

Use one of the following environments:

- Oracle APEX SQL Workshop with a workspace schema; or
- Oracle Database with Oracle SQL Developer or another Oracle-compatible SQL client.

The schema must allow the creation of tables, views, indexes, sequences, procedures, functions, packages and triggers. Creating the optional synonym may require an additional privilege; the local installation script continues when that privilege is unavailable.

## Installation with Oracle APEX

1. Open **SQL Workshop**.
2. Go to **SQL Scripts**.
3. Upload `apex-install.sql`.
4. Run the script.
5. Confirm that the result shows no errors.
6. Upload and run `apex-verification.sql` to check the required tables, sample data and compiled objects.

The installation script has been executed successfully in Oracle APEX SQL Workshop.

## Installation with Oracle SQL Developer

1. Clone or download this repository.
2. Connect to the Oracle schema where the project should be installed.
3. Open `run-project.sql` from the repository root.
4. Run it using **Run Script** (`F5`).

The main script creates the schema, inserts the sample data, applies the updates and creates the reusable SQL and PL/SQL objects.

The files can also be executed manually in this order:

```text
sql/01-schema.sql
sql/02-sample-data.sql
sql/03-data-updates.sql
sql/05-database-objects.sql
plsql/04-procedures.sql
plsql/05-functions.sql
plsql/06-packages.sql
plsql/07-triggers.sql
```

## Running the SQL Examples

Run:

```text
sql/04-queries.sql
```

This file contains numbered examples for filtering, joining, grouping and analysing the project data.

The flashback demonstration is separated from the main installation:

```text
sql/06-flashback-example.sql
```

It uses a temporary demonstration table and does not remove the main project tables.

## Running the PL/SQL Examples

The following files contain anonymous PL/SQL blocks:

```text
plsql/01-control-structures.sql
plsql/02-cursors.sql
plsql/03-exceptions.sql
```

The stored procedures, functions, packages and triggers are created during installation. Their usage is demonstrated in the self-contained script:

```text
plsql/08-usage-examples.sql
```

## Usage Examples

Display a vehicle by its identifier:

```sql
BEGIN
    AfisareVehicul(2);
END;
/
```

Return the number of available vehicles:

```sql
SELECT NumarVehiculeDisponibile() AS vehicule_disponibile
FROM dual;
```

Display all employees through the package:

```sql
BEGIN
    pachet_angajati.AfisareAngajati;
END;
/
```

## Known Limitations

- The project uses fictional academic data and does not include a graphical application.
- Authentication and user roles are outside the scope of the project.
- The scripts target Oracle Database and are not directly compatible with other database systems.
- The trigger that blocks the deletion of old sales depends on the current system date.
- The examples are demonstration scripts rather than an automated test suite.

## Possible Future Improvements

- Add automated tests for procedures, functions and triggers
- Add reporting views for monthly sales and employee performance
- Add audit tables for important data changes
- Use generated identifiers consistently for all tables
- Add a small application or API connected to the database
- Add a digital entity-relationship diagram

## Academic Context

This project was developed as part of a university assignment focused on Oracle SQL and PL/SQL. Both components use the same car dealership database.
