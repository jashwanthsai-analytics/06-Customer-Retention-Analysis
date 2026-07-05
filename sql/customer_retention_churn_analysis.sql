/*====================================================
  Query 1: Total Customers

  Business Question:
  How many customers are present in the dataset?

  Why This Analysis?
  Customer count represents the size of the
  customer base and serves as the foundation
  for all retention, churn, and revenue
  calculations.

====================================================*/

SELECT
    COUNT(*) AS total_customers
FROM Telco_customer_churn;

/*====================================================
  Query 2: Active Customers

  Business Question:
  How many customers are currently active?

  Why This Analysis?
  Active customers represent the current
  revenue-generating customer base and help
  measure customer retention performance.

====================================================*/

SELECT
    COUNT(*) AS active_customers
FROM Telco_customer_churn
WHERE "Churn Label" = 'No';

/*====================================================
  Query 3: Churned Customers

  Business Question:
  How many customers have churned?

  Why This Analysis?
  Churned customers represent lost business
  opportunities and recurring revenue loss.
  Understanding churn volume is critical for
  evaluating customer retention performance.

====================================================*/

SELECT
    COUNT(*) AS churned_customers
FROM Telco_customer_churn
WHERE "Churn Label" = 'Yes';

/*====================================================
  Query 4: Churn Rate

  Business Question:
  What percentage of customers have churned?

  Why This Analysis?
  Churn Rate is one of the most important
  customer retention metrics because it
  measures the proportion of customers who
  discontinue services.

====================================================*/

SELECT
    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM Telco_customer_churn;

/*====================================================
  Query 5: Retention Rate

  Business Question:
  What percentage of customers are retained?

  Why This Analysis?
  Retention Rate measures the company's
  ability to keep customers over time and is
  a key indicator of long-term business
  sustainability.

====================================================*/

SELECT
    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'No' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS retention_rate
FROM Telco_customer_churn;

/*====================================================
  Query 6: Total Revenue

  Business Question:
  How much total revenue has been generated
  from all customers?

  Why This Analysis?
  Revenue is one of the most important
  business metrics because it measures the
  total value generated from customers.

====================================================*/

SELECT
    ROUND(SUM("Total Charges"), 2) AS total_revenue
FROM Telco_customer_churn;

/*====================================================
  Query 7: Churned Revenue

  Business Question:
  How much revenue has been lost from
  churned customers?

  Why This Analysis?
  Churned revenue quantifies the financial
  impact of customer attrition and helps
  estimate revenue recovery opportunities.

====================================================*/

SELECT
    ROUND(SUM("Total Charges"), 2) AS churned_revenue
FROM Telco_customer_churn
WHERE "Churn Label" = 'Yes';

/*====================================================
  Query 8: Churned Revenue Percentage

  Business Question:
  What percentage of total revenue comes
  from churned customers?

  Why This Analysis?
  This metric measures how much business
  value has been lost due to customer churn
  relative to total revenue generated.

====================================================*/

SELECT
    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes'
                THEN "Total Charges"
                ELSE 0
            END
        ) * 100.0
        / SUM("Total Charges"),
        2
    ) AS churned_revenue_percentage
FROM Telco_customer_churn;

/*====================================================
  Query 9: Average Revenue Per User (ARPU)

  Business Question:
  What is the average revenue generated
  per customer?

  Why This Analysis?
  ARPU helps evaluate customer value and is
  commonly used to compare revenue
  performance across customer segments.

====================================================*/

SELECT
    ROUND(
        SUM("Total Charges") * 1.0
        / COUNT(*),
        2
    ) AS arpu
FROM Telco_customer_churn;

/*====================================================
  Query 10: Average Monthly Charges

  Business Question:
  What is the average monthly charge
  paid by customers?

  Why This Analysis?
  Monthly Charges represent recurring
  customer spending and are an important
  driver of revenue generation and customer
  value.

====================================================*/

SELECT
    ROUND(
        AVG("Monthly Charges"),
        2
    ) AS average_monthly_charges
FROM Telco_customer_churn;

/*====================================================
  Query 11: Average Customer Lifetime Value

  Business Question:
  What is the average CLTV across
  all customers?

  Why This Analysis?
  Customer Lifetime Value estimates the
  long-term value generated by customers and
  helps prioritize retention efforts.

====================================================*/

SELECT
    ROUND(
        AVG(CLTV),
        2
    ) AS average_cltv
FROM Telco_customer_churn;

/*====================================================
  Query 12: Average Customer Tenure

  Business Question:
  How long does a customer stay with the
  company on average?

  Why This Analysis?
  Customer tenure is a strong indicator of
  loyalty and retention. Longer tenure often
  leads to higher customer lifetime value.

====================================================*/

SELECT
    ROUND(
        AVG("Tenure Months"),
        2
    ) AS average_tenure_months
FROM Telco_customer_churn;

/*====================================================
  Query 13: Customer Distribution by Gender

  Business Question:
  What is the distribution of customers by gender?

  Why This Analysis?
  Understanding customer demographics helps
  identify the composition of the customer base
  and supports customer segmentation strategies.

====================================================*/

SELECT
    Gender,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Telco_customer_churn),
        2
    ) AS customer_percentage
FROM Telco_customer_churn
GROUP BY Gender
ORDER BY customer_count DESC;

/*====================================================
  Query 14: Customer Distribution by Senior Citizen

  Business Question:
  How are customers distributed by senior
  citizen status?

  Why This Analysis?
  Senior citizens may exhibit different
  purchasing and retention behaviors compared
  to other customer segments.

====================================================*/

SELECT
    "Senior Citizen",
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Telco_customer_churn),
        2
    ) AS customer_percentage
FROM Telco_customer_churn
GROUP BY "Senior Citizen"
ORDER BY customer_count DESC;

/*====================================================
  Query 15: Customer Distribution by Contract Type

  Business Question:
  What is the customer distribution across
  contract types?

  Why This Analysis?
  Contract type influences customer commitment
  and is an important factor in retention
  analysis.

====================================================*/

SELECT
    Contract,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Telco_customer_churn),
        2
    ) AS customer_percentage
FROM Telco_customer_churn
GROUP BY Contract
ORDER BY customer_count DESC;

/*====================================================
  Query 16: Customer Distribution by Internet Service

  Business Question:
  How are customers distributed across
  internet service types?

  Why This Analysis?
  Internet service is one of the primary
  products offered by the company and may
  influence customer behavior and churn.

====================================================*/

SELECT
    "Internet Service",
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Telco_customer_churn),
        2
    ) AS customer_percentage
FROM Telco_customer_churn
GROUP BY "Internet Service"
ORDER BY customer_count DESC;

/*====================================================
  Query 17: Customer Distribution by Payment Method

  Business Question:
  What payment methods are most commonly used
  by customers?

  Why This Analysis?
  Payment preferences may influence customer
  convenience, billing experience, and
  retention behavior.

====================================================*/

SELECT
    "Payment Method",
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Telco_customer_churn),
        2
    ) AS customer_percentage
FROM Telco_customer_churn
GROUP BY "Payment Method"
ORDER BY customer_count DESC;

/*====================================================
  Query 18: Churn Rate by Gender

  Business Question:
  Does churn behavior differ by gender?

  Why This Analysis?
  Gender-based churn analysis helps identify
  whether retention performance varies across
  demographic groups.

====================================================*/

SELECT
    Gender,

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN "Churn Label" = 'Yes'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes'
                THEN 1
                ELSE 0
            END
        ) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate

FROM Telco_customer_churn

GROUP BY Gender

ORDER BY churn_rate DESC;

/*====================================================
  Query 19: Churn Rate by Senior Citizen Status

  Business Question:
  Does churn behavior differ between senior
  citizens and non-senior customers?

  Why This Analysis?
  Senior citizens may have different service
  expectations and retention patterns.

====================================================*/

SELECT
    "Senior Citizen",

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN "Churn Label" = 'Yes'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes'
                THEN 1
                ELSE 0
            END
        ) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate

FROM Telco_customer_churn

GROUP BY "Senior Citizen"

ORDER BY churn_rate DESC;

/*====================================================
  Query 20: Churn Rate by Contract Type

  Business Question:
  Which contract type experiences the highest
  customer churn?

  Why This Analysis?
  Contract commitment is one of the strongest
  predictors of customer retention.

====================================================*/

SELECT
    Contract,

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN "Churn Label" = 'Yes'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes'
                THEN 1
                ELSE 0
            END
        ) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate

FROM Telco_customer_churn

GROUP BY Contract

ORDER BY churn_rate DESC;

/*====================================================
  Query 21: Churn Rate by Internet Service

  Business Question:
  Which internet service segment has the
  highest churn rate?

====================================================*/

SELECT
    "Internet Service",

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN "Churn Label" = 'Yes'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes'
                THEN 1
                ELSE 0
            END
        ) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate

FROM Telco_customer_churn

GROUP BY "Internet Service"

ORDER BY churn_rate DESC;

/*====================================================
  Query 22: Customer Segmentation by Tenure

  Business Question:
  How are customers distributed across
  different tenure groups?

  Why This Analysis?
  Customer tenure is one of the strongest
  indicators of loyalty and retention.

====================================================*/

SELECT

    CASE

        WHEN "Tenure Months" BETWEEN 0 AND 12
            THEN '0-12 Months'

        WHEN "Tenure Months" BETWEEN 13 AND 24
            THEN '13-24 Months'

        WHEN "Tenure Months" BETWEEN 25 AND 48
            THEN '25-48 Months'

        ELSE '49-72 Months'

    END AS tenure_group,

    COUNT(*) AS customer_count,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Telco_customer_churn),
        2
    ) AS customer_percentage

FROM Telco_customer_churn

GROUP BY tenure_group

ORDER BY customer_count DESC;

/*====================================================
  Query 23: Churn Rate by Tenure Group

  Business Question:
  Which tenure group experiences the
  highest churn?

  Why This Analysis?
  Understanding churn across the customer
  lifecycle helps identify when retention
  efforts should be focused.

====================================================*/

SELECT

    CASE

        WHEN "Tenure Months" BETWEEN 0 AND 12
            THEN '0-12 Months'

        WHEN "Tenure Months" BETWEEN 13 AND 24
            THEN '13-24 Months'

        WHEN "Tenure Months" BETWEEN 25 AND 48
            THEN '25-48 Months'

        ELSE '49-72 Months'

    END AS tenure_group,

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN "Churn Label" = 'Yes'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes'
                THEN 1
                ELSE 0
            END
        ) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate

FROM Telco_customer_churn

GROUP BY tenure_group

ORDER BY churn_rate DESC;

/*====================================================
  Query 24: Customer Segmentation by
            Monthly Charges

  Business Question:
  How are customers distributed across
  pricing segments?

====================================================*/

SELECT

    CASE

        WHEN "Monthly Charges" <= 35
            THEN 'Low ($0-$35)'

        WHEN "Monthly Charges" <= 70
            THEN 'Medium ($35-$70)'

        WHEN "Monthly Charges" <= 90
            THEN 'High ($70-$90)'

        ELSE 'Premium ($90+)'

    END AS charge_group,

    COUNT(*) AS customer_count,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Telco_customer_churn),
        2
    ) AS customer_percentage

FROM Telco_customer_churn

GROUP BY charge_group

ORDER BY customer_count DESC;

/*====================================================
  Query 25: Churn Rate by Monthly Charge Group

  Business Question:
  Do customers paying higher monthly
  charges churn more frequently?

====================================================*/

SELECT

    CASE

        WHEN "Monthly Charges" <= 35
            THEN 'Low ($0-$35)'

        WHEN "Monthly Charges" <= 70
            THEN 'Medium ($35-$70)'

        WHEN "Monthly Charges" <= 90
            THEN 'High ($70-$90)'

        ELSE 'Premium ($90+)'

    END AS charge_group,

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN "Churn Label" = 'Yes'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes'
                THEN 1
                ELSE 0
            END
        ) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate

FROM Telco_customer_churn

GROUP BY charge_group

ORDER BY churn_rate DESC;

/*====================================================
  Query 26: High-Risk Customers Using CTE

  Business Question:
  How many customers belong to the identified
  high-risk churn profile?

  Why This Analysis?
  Previous analysis identified a high-risk
  customer profile:
  
  - Month-to-Month Contract
  - Fiber Optic Service
  - Electronic Check Payment

  This query measures the size of that segment.

====================================================*/

WITH high_risk_customers AS (

    SELECT *
    
    FROM Telco_customer_churn
    
    WHERE Contract = 'Month-to-month'
      AND "Internet Service" = 'Fiber optic'
      AND "Payment Method" = 'Electronic check'

)

SELECT
    COUNT(*) AS high_risk_customer_count
FROM high_risk_customers;

/*====================================================
  Query 27: Churn Rate of High-Risk Customers

  Business Question:
  What is the churn rate among customers
  belonging to the high-risk profile?

====================================================*/

WITH high_risk_customers AS (

    SELECT *
    
    FROM Telco_customer_churn
    
    WHERE Contract = 'Month-to-month'
      AND "Internet Service" = 'Fiber optic'
      AND "Payment Method" = 'Electronic check'

)

SELECT

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN "Churn Label" = 'Yes'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes'
                THEN 1
                ELSE 0
            END
        ) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate

FROM high_risk_customers;

/*====================================================
  Query 28: Top 10 Customers by CLTV

  Business Question:
  Who are the most valuable customers based
  on Customer Lifetime Value?

  Why This Analysis?
  Identifying high-value customers helps
  prioritize retention efforts.

====================================================*/

SELECT *

FROM (

    SELECT

        "CustomerID",
        CLTV,

        ROW_NUMBER() OVER(
            ORDER BY CLTV DESC
        ) AS customer_rank

    FROM Telco_customer_churn

)

WHERE customer_rank <= 10;

/*====================================================
  Query 29: Customer Ranking by Revenue

  Business Question:
  Which customers have generated the highest
  revenue?

====================================================*/

SELECT

    "CustomerID",

    "Total Charges",

    RANK() OVER(
        ORDER BY "Total Charges" DESC
    ) AS revenue_rank

FROM Telco_customer_churn

LIMIT 10;

/*====================================================
  Query 30: Customer Ranking by CLTV

  Business Question:
  How do customers rank by Customer
  Lifetime Value?

====================================================*/

SELECT

    "CustomerID",

    CLTV,

    DENSE_RANK() OVER(
        ORDER BY CLTV DESC
    ) AS cltv_rank

FROM Telco_customer_churn

LIMIT 10;

/*====================================================
  Query 31: Top High-Risk Customer Segments

  Business Question:
  Which customer segments should be prioritized
  for retention initiatives?

====================================================*/

SELECT
    Contract,
    "Internet Service",
    "Payment Method",

    COUNT(*) AS customer_count,

    ROUND(
        SUM(
            CASE
                WHEN "Churn Label" = 'Yes'
                THEN 1
                ELSE 0
            END
        ) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate

FROM Telco_customer_churn

GROUP BY
    Contract,
    "Internet Service",
    "Payment Method"

HAVING COUNT(*) >= 50

ORDER BY churn_rate DESC

LIMIT 10;

