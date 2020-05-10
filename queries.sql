select  h.card_holder_id, h.card_holder_name,t.credit_card,t.date,t.amount,t.merch_id, md.merch_name, mcat.merch_category_id, mcat.merch_category
from transactions t
join credit_cards c on t.credit_card = c.credit_card
join card_holders h ON h.card_holder_id = c.card_holder_id
join merchant_details md ON md.merch_id = t.merch_id
join merchant_category mcat ON mcat.merch_category_id = md.merch_category_id
order by c.card_holder_id, t.credit_card
;


-- Consider the time period 7:00 a.m. to 9:00 a.m.

-- -- What are the 100 highest transactions during this time period?

-- using between is inclusive, its not clear from the Question whether we want 
-- to use it as a range not including transactions from 9:00 am
-- however, in this data set there are not transactions
-- between 8:59am - 9:00am so it wouldn't matter

select t.* from transactions t
where cast(t.date as time) between '07:00:00' and '09:00:00'
order by amount desc , credit_card
limit 100
;


-- Count transactions less than $2.00 per cardholder 
-- (adding credit card as well as cardholders may have multiple cards)
select h.card_holder_id,h.card_holder_name, t.credit_card, count(*) from transactions t
join credit_cards c on c.credit_card=t.credit_card
join card_holders h ON h.card_holder_id = c.card_holder_id
where t.amount < 2.00
group by t.credit_card, h.card_holder_id, h.card_holder_name
order by  h.card_holder_name, t.credit_card
;


--What are the top five merchants prone to being hacked using small transactions?
select t.merch_id, m.merch_name, count(*) as num_of_low_trans from transactions t
join merchant_details m on m.merch_id = t.merch_id
where t.amount <2.00
group by t.merch_id, m.merch_name
order by num_of_low_trans desc
limit 5


--CREATING VIEWS FOR ALL THE TOP QUERIES--

create view transactions_bunched_by_card_holder
as
(
select  h.card_holder_id, h.card_holder_name,t.credit_card,t.date,t.amount,t.merch_id, md.merch_name, mcat.merch_category_id, mcat.merch_category
from transactions t
join credit_cards c on t.credit_card = c.credit_card
join card_holders h ON h.card_holder_id = c.card_holder_id
join merchant_details md ON md.merch_id = t.merch_id
join merchant_category mcat ON mcat.merch_category_id = md.merch_category_id
order by c.card_holder_id, t.credit_card
);

create view top_100_highest_transactions
as
(
select t.* from transactions t
where cast(t.date as time) between '07:00:00' and '09:00:00'
order by amount desc , credit_card
limit 100
);

create view transactions_below_2dollar
as
(select h.card_holder_id,h.card_holder_name, t.credit_card, count(*) from transactions t
join credit_cards c on c.credit_card=t.credit_card
join card_holders h ON h.card_holder_id = c.card_holder_id
where t.amount < 2.00
group by t.credit_card, h.card_holder_id, h.card_holder_name
order by  h.card_holder_name, t.credit_card
);


create view top_five_merchant_hacked
as 
(--What are the top five merchants prone to being hacked using small transactions?
select t.merch_id, m.merch_name, count(*) as num_of_low_trans from transactions t
join merchant_details m on m.merch_id = t.merch_id
where t.amount <2.00
group by t.merch_id, m.merch_name
order by num_of_low_trans desc
limit 5);

