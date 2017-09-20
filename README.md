# sierra-fines-extract

##### sierra_fines.sql
Run this query to extract all fines from your Sierra system. The following fields will be extracted in this query. 
```
"RECORD #(PATRON)","RECORD #(ITEM)","ASSESSED DATE","TOTAL CHARGES","INVOICE","PAID AMOUNT","ITEM FEE","PROCESSING FEE","BILLING FEE","FINE COMMENT","OUT DATE","DUE DATE","RETURNED DATE","CHARGE TYPE","ITEM TITLE","OVERDUE DATE","DELETED INFO","VIRTUAL REC NUM"
```

##### readfines.php
Run the following command to add the check digit to the patron and item record columns, where ‘originalfinesfile.csv’ is the name of your current exported fines file:

`php readfines.php originalfinesfile.csv > newfinesfile.csv`
