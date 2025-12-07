--Datenbank: sample
--Tabellen: customers, orders, order_details, products

--FEUER FREI - TIME OF JOINS

--1. WIE VIELE BESTELLUNGEN HABEN DIE KUNDEN 
--   (KUNDENNAME, ANZAHL BESTELLUNGEN - ABSTEIGEND NACH ANZAHL BESTELLUNGEN)

--2. WELCHER KUNDE HAT AM HÄUFIGSTEN BESTELLT?

--3. WER IST UNSER ÄLTESTER KUNDE?

--4. WER IST UNSER BESTER KUNDE (NACH UMSATZ)?

--5. WELCHER KUNDE HAT DIE HÖCHSTE STÜCKZAHL EINES PRODUKTES BESTELLT?

--6. WELCHER KUNDE HAT DIE HÖCHSTE STÜCKZAHL INSGESAMT BESTELLT?

--7. WIE VIELE PRODUKTE WERDEN PRO MONAT IM JAHR 2023 bestellt?

SELECT DISTINCT MONTH(order_date) AS "MONAT 2023", SUM(od.quantity) AS "ANZ PRODUKTE" 
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

--8. IN WELCHEM MONAT WERDEN DIE MEISTEN PRODUKTE - STK. BERÜCKSICHTIGEN ! - BESTELLT?
SELECT * FROM order_details;

SELECT TOP 1 MONTH(o.order_date) AS MONAT, SUM(od.quantity) AS STUECK
FROM orders AS o
LEFT JOIN order_details AS od 
ON o.order_id = od.order_id
GROUP BY MONTH(o.order_date)
ORDER BY STUECK DESC;

--9. WELCHER MONAT IN WELCHEM JAHR WAR DER ERFOLGREICHSTE MONAT IN BEZUG AUF UMSATZ?
SELECT * FROM products;

SELECT * FROM order_details;

SELECT TOP 1 YEAR(o.order_date) AS JAHR, MONTH(o.order_date) AS MONAT, SUM(p.price*od.quantity) AS UMSATZ
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
LEFT JOIN products AS p
ON od.product_id = p.product_id
GROUP BY o.order_date
ORDER BY UMSATZ DESC;

--9. UM WELCHEN MONAT DES LETZTEN ERFASSTEN JAHRES MÜSSEN WIR UNS BESONDERS KÜMMERN, 
--   WEIL BESONDERS WENIG UMSATZ GEMACHT WURDE?

--SELECT TOP 1 YEAR(o.order_date), MONTH(o.order_date) AS MONAT, SUM(p.price*od.quantity) AS UMSATZ
SELECT YEAR(o.order_date), MONTH(o.order_date) AS MONAT,SUM(p.price*od.quantity) AS UMSATZ
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
LEFT JOIN products AS p
ON od.product_id = p.product_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY UMSATZ ASC;

--10. WIE SEHEN DIE MONATSUMSÄTZE DES MONATS AUS 9.) IM VERLAUF ALLER ERFASSTEN JAHRE AUS?

SELECT MONTH(o.order_date) AS MONAT, YEAR(o.order_date), SUM(p.price*od.quantity) AS UMSATZ
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
LEFT JOIN products AS p
ON od.product_id = p.product_id
GROUP BY MONTH(o.order_date), YEAR(o.order_date)
HAVING MONTH(o.order_date) = 5
ORDER BY YEAR(o.order_date) DESC, UMSATZ ASC;

--11. WIE HOCH IST DER DURCHSCHNITTLICHE BESTELLWERT ALLER BESTELLUNGEN IM JAHR 2023?

--SELECT YEAR(o.order_date), MONTH(o.order_date), price, quantity, price*quantity
--FROM orders AS o
--JOIN order_details AS od
--ON o.order_id = od.order_id
--JOIN products AS p
--ON p.product_id = od.product_id
--WHERE YEAR(o.order_date) = 2023 AND MONTH(o.order_date) = 1;

--SELECT AVG(price*quantity) 
--FROM orders AS o
--JOIN order_details AS od
--ON o.order_id = od.order_id
--JOIN products AS p
--ON p.product_id = od.product_id
--WHERE YEAR(o.order_date) = 2023 AND MONTH(o.order_date) = 1;

SELECT FORMAT(AVG(p.price*od.quantity), 'N2') AS UMSATZ
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
LEFT JOIN products AS p
ON od.product_id = p.product_id
WHERE YEAR(o.order_date) = 2023;

--https://sqlserverguides.com/format-number-with-commas-and-decimal-in-sql-server/