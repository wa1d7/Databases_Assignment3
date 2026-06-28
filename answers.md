# Bonus Task 2 — Theory Questions

**1. What is the difference between a function and a procedure in PostgreSQL?**
A function always returns a value, so you can call it directly inside a `SELECT`. A procedure doesn't return anything - you run it with `CALL`. The other difference is that a procedure can do `COMMIT` or `ROLLBACK` inside itself, which a function can't.

**2. Can a trigger be executed manually? Why or why not?**
No. A trigger doesn't have a way to be called directly - it only fires in response to a table event like `INSERT`, `UPDATE`, or `DELETE`. If you want the same logic to run manually, you'd have to put it in a separate function and call that.

**3. What are the advantages and disadvantages of storing business logic inside the database?**

**Advantages:** The rules are enforced at the data level, so it doesn't matter which application or tool is writing to the database - the logic always runs. It can also reduce load on the application side since processing happens closer to the data.

**Disadvantages:** This code is much harder to test and debug than regular application code. It also locks you into a specific database engine - logic written for PostgreSQL usually doesn't transfer cleanly if you ever switch to something else.
