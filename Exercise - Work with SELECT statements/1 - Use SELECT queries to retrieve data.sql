-- CHALLENGE 1
-- Retrieve Customer Data

SELECT 
    CustomerID, NameStyle, Title, FirstName, MiddleName, 
    LastName, Suffix, CompanyName, SalesPerson, 
    EmailAddress, Phone, PasswordHash, PasswordSalt, 
    rowguid, ModifiedDate
FROM SalesLT.Customer;

Select * from SalesLT.Customer;

-- Retrieve customer name data

SELECT 
    CustomerID,
    CONCAT_WS(' ', Title, FirstName, MiddleName, LastName, Suffix) AS CustomerContactName
FROM SalesLT.Customer;

-- Retrieve customer names and phone numbers

SELECT 
    SalesPerson,
    CONCAT_WS(' ', Title, LastName) AS CustomerName,
    Phone
FROM SalesLT.Customer;

-- CHALLENGE 2
-- Retrieve a list of customer companies

SELECT 
    CONCAT(CAST(CustomerID AS VARCHAR(10)), ': ', CompanyName) AS CustomerCompany
FROM SalesLT.Customer;

-- Retrieve a list of sales order revisions

SELECT 
    SalesOrderID,
    CONCAT(COALESCE(PurchaseOrderNumber, 'No PO'), ' (', CAST(RevisionNumber AS VARCHAR(5)), ')') AS OrderRevision,
    CONVERT(VARCHAR(10), OrderDate, 102) AS FormattedOrderDate
FROM SalesLT.SalesOrderHeader;

-- CHALLENGE 3
-- Retrieve customer contact names with middle names if known

SELECT 
    CustomerID,
    CONCAT_WS(' ', FirstName, MiddleName, LastName) AS FullName
FROM SalesLT.Customer;

-- Retrieve primary contact details

UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID % 7 = 1;

SELECT 
    CustomerID,
    COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer;

-- Retrieve shipping status

UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899;

SELECT 
    SalesOrderID,
    OrderDate,
    CASE 
        WHEN ShipDate IS NOT NULL THEN 'Shipped'
        ELSE 'Awaiting Shipment'
    END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;