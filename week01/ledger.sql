-- Create the accounts table
CREATE TABLE accounts (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    credit FLOAT,
    bank_name VARCHAR(50)
);

-- Insert 3 accounts with 1000 RUB credit each
INSERT INTO accounts VALUES (1, 'Account 1', 1000, 'SpearBank');
INSERT INTO accounts VALUES (2, 'Account 2', 1000, 'Tinkoff');
INSERT INTO accounts VALUES (3, 'Account 3', 1000, 'SpearBank');

-- Create the fees account
INSERT INTO accounts VALUES (4, 'Fees Account', 0, '');

-- Perform the transactions
INSERT INTO ledger VALUES (1, 1, 3, 0, 500, NOW());
UPDATE accounts SET credit = credit - 500 WHERE id = 1;
UPDATE accounts SET credit = credit + 500 WHERE id = 3;

INSERT INTO ledger VALUES (2, 2, 1, 0, 700, NOW());
UPDATE accounts SET credit = credit + 700 WHERE id = 1;
UPDATE accounts SET credit = credit - 700 WHERE id = 2;

INSERT INTO ledger VALUES (3, 2, 3, 0, 100, NOW());
UPDATE accounts SET credit = credit - 100 WHERE id = 2;
UPDATE accounts SET credit = credit + 100 WHERE id = 3;

-- Add bank name to the accounts table
UPDATE accounts SET bank_name = 'SpearBank' WHERE id IN (1, 3);
UPDATE accounts SET bank_name = 'Tinkoff' WHERE id = 2;

-- Calculate and return the credit for all accounts
SELECT id, name, credit FROM accounts;

-- Create the ledger table
CREATE TABLE ledger (
    id INT PRIMARY KEY,
    from_account INT,
    to_account INT,
    fee FLOAT,
    amount FLOAT,
    transaction_datetime DATETIME
);

-- Save all transactions into the ledger table
INSERT INTO ledger (from_account, to_account, fee, amount, transaction_datetime)
VALUES (1, 3, 0, 500, NOW());

INSERT INTO ledger (from_account, to_account, fee, amount, transaction_datetime)
VALUES (2, 1, 0, 700, NOW());

INSERT INTO ledger (from_account, to_account, fee, amount, transaction_datetime)
VALUES (2, 3, 0, 100, NOW());

-- Display the ledger 
SELECT * FROM ledger;