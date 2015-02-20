SELECT
	ne_bills.`session` as legislative_session,
	ne_bills.bill_id as bill_number,
	ne_bills.title as bill_title,
	ne_bills.type as bill_type,
	ne_bill_sponsors.type as sponsor_type,
	ne_bill_sponsors.`name` as sponsor_name,
	ne_bill_sponsors.leg_id as openstates_legislator_id,
	actions.type as last_action
FROM
	ne_bill_sponsors,
	ne_bills,
	(
		SELECT
			ne_bill_actions.type,
			ne_bill_actions.bill_id
		FROM
			ne_bill_actions
		WHERE
			ne_bill_actions.`session` = 102
		GROUP BY
			ne_bill_actions.bill_id
		ORDER BY
			ne_bill_actions.date ASC
	) AS actions
WHERE
	ne_bill_sponsors.bill_id = ne_bills.bill_id
AND ne_bills.bill_id = actions.bill_id
AND ne_bills.`session` = 102
