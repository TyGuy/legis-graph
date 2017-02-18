USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'http://localhost:8000/outputs/bills.csv'
AS line
MERGE (bill:Bill { billID: line.billID })
    ON CREATE SET bill = line,
      bill.enacted = (CASE line.enacted WHEN 'False' THEN false ELSE true END),
      bill.vetoed = (CASE line.vetoed WHEN 'False' THEN false ELSE true END),
      bill.active = (CASE line.active WHEN 'False' THEN false ELSE true END)
    ON MATCH SET bill = line,
      bill.enacted = (CASE line.enacted WHEN 'False' THEN false ELSE true END),
      bill.vetoed = (CASE line.vetoed WHEN 'False' THEN false ELSE true END),
      bill.active = (CASE line.active WHEN 'False' THEN false ELSE true END);
CREATE INDEX ON :Bill(billID);
