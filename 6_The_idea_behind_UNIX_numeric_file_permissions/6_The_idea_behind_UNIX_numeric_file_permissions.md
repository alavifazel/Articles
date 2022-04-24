# The idea behind UNIX numeric file permissions

Any UNIX user is probably familiar with the **chmod** command.
In short, this command changes the permission of a file (or directory) with the desired permisison level for the *owner*,
*group* and *everyone else* in the system.

For instance, the following command:

> chmod 755 filename.txt

Changes the permission of *filename.txt* to **read, write, execute** for
the *owner*, and **read and execute** for *group* and *everyone*
respectively.

The way that the number 755 carries this information is that each digit
(7 or 5 in this example) is an addition of the following numbers that
have special meanings for UNIX:

-   *1* for execution permission.

-   *2* for write permission.

-   *4* for read permission.

In our example, 5 is the result of (1 + 4) and the OS concluded that we
needed both **read** and **execution** permissions.

What I was wondering was how there was a guarantees that a number in
this system is only the result of specific numbers? For example, how can
we be sure that 5 is not the result of adding up number other that 1 and
4 in our system? (Of course, since our choices are limited in this
senario we could simply list out all the items that the basis numbers 1,
2 and 4 make and check them all out. But I was looking for a more
generalized logic)

A short pondering about this question made me realized that the numbers
*1*, *2* and *4*, which are used as basis numbers, are all in base 2!
Hence, the number 5 in binary is *101*, which the OS can clearly
conclude that we intended to have both read and execution options for
our file.

Can we extend this idea to carry information that aren't consist of
**on-or-off** options like in file permissions? For this, let's take a
look at a case (probably useless and with a poor software design choice)
just to have a concret example:

A restaurant application software has 15 types of meals and 6 types of
canned soda, and we want to represent the order of a customer (including
both the meal and soda type) with a single decimal number.

Let's say we have the following table for **meals**:

  ---- ---------------
  ID   Name
  .    .
  5    Chicken Wings
  .    .
  ---- ---------------

And the following for **soda types**:

  ---- -------------------
  ID   Name
  .    .
  2    Coca-Cola Classic
  .    .
  ---- -------------------

Therefore, the number $5 + (16*2) = 37$ (in decimal) can represent an
order of Chicken Wings with Coca-Cola Classics. When this number is
converted to base 16, it yields 25, where each digit (2 and 5) represent
an ID from their example tables.

Although this example is probably not a practical one, it was examplify the generalized
the idea behind the concept of file permissions in UNIX.
