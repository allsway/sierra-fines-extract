/*
	Retrieves all current patron fines from Sierra
*/

SELECT 
    id2reckey(patron_record_id) AS "RECORD #(PATRON)",
    concat(item_view.record_type_code,item_view.record_num) AS "RECORD #(ITEM)",
    assessed_gmt AS "ASSESSED DATE",
    (item_charge_amt+processing_fee_amt+billing_fee_amt) AS "TOTAL CHARGES",
    invoice_num AS "INVOICE",
    paid_amt AS "PAID AMOUNT",
    item_charge_amt AS "ITEM FEE",
    processing_fee_amt AS "PROCESSING FEE",
    billing_fee_amt as"BILLING FEE",
    description AS "FINE COMMENT",
    checkout_gmt AS "OUT DATE",
    due_gmt AS "DUE DATE",
    returned_gmt AS "RETURNED DATE",
    charge_code AS "CHARGE TYPE",
    'Record ' || record_metadata.record_type_code || record_metadata.record_num || ' deleted on ' || deletion_date_gmt  AS "DELETED INFO", 
    CASE WHEN campus_code!='' THEN record_metadata.record_type_code || record_metadata.record_num || '@' || campus_code
    END AS "VIRTUAL REC NUM"
FROM sierra_view.fine 
LEFT JOIN sierra_view.item_view ON sierra_view.fine.item_record_metadata_id=sierra_view.item_view.id
LEFT JOIN sierra_view.record_metadata ON fine.item_record_metadata_id=record_metadata.id ORDER BY 1;
