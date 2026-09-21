-- ============================================================
-- E-COMMERCE RETURNS & REVERSE LOGISTICS ANALYTICS
-- SQL Analysis Queries
-- Database: ecommerce_returns
-- ============================================================


-- ============================================================
-- 1. OVERALL RETURN RATE & TOTAL RETURN COST
-- ============================================================

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT r.order_id) AS returned_orders,
    ROUND(
        COUNT(DISTINCT r.order_id) * 100.0
        / COUNT(DISTINCT o.order_id),
        2
    ) AS return_rate_percent,
    ROUND(
        SUM(
            r.refund_amount
            + r.reverse_shipping_cost
            + r.restocking_loss
        ),
        2
    ) AS total_return_cost
FROM orders o
LEFT JOIN returns r
    ON o.order_id = r.order_id;


-- ============================================================
-- 2. RETURN RATE: COD VS PREPAID
-- ============================================================

SELECT
    o.payment_method,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT r.order_id) AS returned_orders,
    ROUND(
        COUNT(DISTINCT r.order_id) * 100.0
        / COUNT(DISTINCT o.order_id),
        2
    ) AS return_rate_percent
FROM orders o
LEFT JOIN returns r
    ON o.order_id = r.order_id
GROUP BY o.payment_method
ORDER BY return_rate_percent DESC;


-- ============================================================
-- 3. RETURN RATE BY CITY
-- ============================================================

SELECT
    o.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT r.order_id) AS returned_orders,
    ROUND(
        COUNT(DISTINCT r.order_id) * 100.0
        / COUNT(DISTINCT o.order_id),
        2
    ) AS return_rate_percent
FROM orders o
LEFT JOIN returns r
    ON o.order_id = r.order_id
GROUP BY o.city
ORDER BY return_rate_percent DESC;


-- ============================================================
-- 4. RETURN RATE BY PRODUCT CATEGORY
-- ============================================================

SELECT
    o.category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT r.order_id) AS returned_orders,
    ROUND(
        COUNT(DISTINCT r.order_id) * 100.0
        / COUNT(DISTINCT o.order_id),
        2
    ) AS return_rate_percent
FROM orders o
LEFT JOIN returns r
    ON o.order_id = r.order_id
GROUP BY o.category
ORDER BY return_rate_percent DESC;


-- ============================================================
-- 5. RETURN REASONS BY PRODUCT CATEGORY
-- ============================================================

SELECT
    o.category,
    r.return_reason,
    COUNT(*) AS return_count
FROM returns r
JOIN orders o
    ON r.order_id = o.order_id
GROUP BY
    o.category,
    r.return_reason
ORDER BY
    o.category,
    return_count DESC;


-- ============================================================
-- 6. MONTHLY RETURN TREND
-- ============================================================

SELECT
    DATE_FORMAT(r.return_date, '%Y-%m') AS return_month,
    COUNT(*) AS returned_orders,
    ROUND(
        COUNT(*) * 100.0
        / (
            SELECT COUNT(*)
            FROM orders o
            WHERE DATE_FORMAT(o.order_date, '%Y-%m')
                = DATE_FORMAT(r.return_date, '%Y-%m')
        ),
        2
    ) AS return_rate_percent
FROM returns r
GROUP BY DATE_FORMAT(r.return_date, '%Y-%m')
ORDER BY return_month;


-- ============================================================
-- 7. MONTH-OVER-MONTH RETURN RATE CHANGE
-- ============================================================

WITH monthly_returns AS (
    SELECT
        DATE_FORMAT(r.return_date, '%Y-%m') AS return_month,
        COUNT(*) AS returned_orders,
        (
            SELECT COUNT(*)
            FROM orders o
            WHERE DATE_FORMAT(o.order_date, '%Y-%m')
                = DATE_FORMAT(r.return_date, '%Y-%m')
        ) AS total_orders
    FROM returns r
    GROUP BY DATE_FORMAT(r.return_date, '%Y-%m')
),

monthly_rates AS (
    SELECT
        return_month,
        returned_orders,
        total_orders,
        ROUND(
            returned_orders * 100.0 / total_orders,
            2
        ) AS return_rate_percent
    FROM monthly_returns
)

SELECT
    return_month,
    returned_orders,
    total_orders,
    return_rate_percent,
    ROUND(
        return_rate_percent
        - LAG(return_rate_percent) OVER (
            ORDER BY return_month
        ),
        2
    ) AS mom_change_percentage_points
FROM monthly_rates
ORDER BY return_month;


-- ============================================================
-- 8. TOP PRODUCTS BY TOTAL RETURN COST
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(r.return_id) AS return_count,
    ROUND(
        SUM(
            r.refund_amount
            + r.reverse_shipping_cost
            + r.restocking_loss
        ),
        2
    ) AS total_return_cost
FROM returns r
JOIN orders o
    ON r.order_id = o.order_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_return_cost DESC
LIMIT 10;


-- ============================================================
-- 9. AVERAGE DAYS FROM DELIVERY TO RETURN BY CATEGORY
-- ============================================================

SELECT
    o.category,
    ROUND(
        AVG(
            DATEDIFF(
                r.return_date,
                o.delivery_date
            )
        ),
        2
    ) AS average_days_to_return
FROM returns r
JOIN orders o
    ON r.order_id = o.order_id
GROUP BY o.category
ORDER BY average_days_to_return DESC;
