/*
	Retrieves all current patron fines from Sierra
*/

SELECT 
    id2reckey(patron_record_id) AS "RECORD #(PATRON)",
    concat(item_view.record_type_code,item_view.record_num) AS "RECORD #(ITEM)",
    assessed_gmt AS "ASSESSED DATE",
    trunc((item_charge_amt+processing_fee_amt+billing_fee_amt),2) AS "TOTAL CHARGES",
    invoice_num AS "INVOICE",
    trunc(paid_amt,2) AS "PAID AMOUNT",
    trunc(item_charge_amt,2) AS "ITEM FEE",
    trunc(processing_fee_amt,2) AS "PROCESSING FEE",
    trunc(billing_fee_amt,2) as"BILLING FEE",
    description AS "FINE COMMENT",
    checkout_gmt AS "OUT DATE",
    due_gmt AS "DUE DATE",
    returned_gmt AS "RETURNED DATE",
    charge_code AS "CHARGE TYPE",
    title AS "ITEM TITLE",
    'Record ' || record_metadata.record_type_code || record_metadata.record_num || ' deleted on ' || deletion_date_gmt  AS "DELETED INFO", 
    CASE WHEN campus_code!='' THEN record_metadata.record_type_code || record_metadata.record_num || '@' || campus_code
    END AS "VIRTUAL REC NUM"
FROM sierra_view.fine 
LEFT JOIN sierra_view.item_view ON sierra_view.fine.item_record_metadata_id=sierra_view.item_view.id
LEFT JOIN sierra_view.record_metadata ON fine.item_record_metadata_id=record_metadata.id ORDER BY 1;
