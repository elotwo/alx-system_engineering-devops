Postmortem: API Outage on Food Delivery Service
Issue Summary:
Duration:

Start: September 24, 2024, 14:30 UTC
End: September 24, 2024, 15:15 UTC
Total duration: 45 minutes
Impact:
During the outage, users were unable to access the RESTful API for placing orders through our food delivery platform. Approximately 70% of the users experienced errors such as failed order placements, inability to view available restaurants, and slow response times from the app. Affected users received timeout errors or "Service Unavailable" messages, impacting both mobile and web platforms.

Root Cause:
The root cause was a misconfigured database query that led to excessive resource consumption on the primary database server, causing it to fail under high load.
Timeline:
14:30 UTC: Monitoring system detected elevated API error rates and slow response times.
14:32 UTC: Engineers received automated alerts and began investigation.
14:35 UTC: Initial assumption was network latency due to a DDoS attack or a sudden traffic surge.
14:40 UTC: The database and API servers were checked, and the network team was consulted. No external traffic anomalies were found.
14:45 UTC: Focus shifted to database performance. Engineers noted high resource consumption but couldn’t identify the query causing it.
14:50 UTC: Database logs indicated repeated execution of a poorly optimized query.
14:55 UTC: The backend team was informed, and the problematic query was isolated and reviewed.
15:00 UTC: The database query was optimized by adding proper indexing, and the API service was restored.
15:15 UTC: Full service recovery confirmed, and monitoring showed error rates returning to normal levels.
Root Cause and Resolution:
Root Cause:
The issue stemmed from a query used in the API to fetch available restaurant listings, which lacked proper indexing on a key table. During peak traffic, this query was executed frequently, placing a heavy load on the database server. The lack of optimization caused excessive disk I/O, leading to database timeouts and failure in API responses.

Resolution:
The problematic query was rewritten with appropriate indexing on the frequently queried fields. This reduced the execution time of the query from several seconds to under 100ms. After the fix, the API performance stabilized, and normal service was restored.
Corrective and Preventative Measures:
Improvements/Fixes:

Query Optimization: All database queries will undergo review to ensure proper indexing and efficient execution.
Monitoring: Enhanced monitoring will be implemented to track slow-running queries in real-time and alert the team before an outage occurs.
Load Testing: Regular load testing will be performed to simulate peak traffic scenarios and ensure the system can handle the expected load.
Failover Strategy: Introduce a failover mechanism to automatically switch to a read replica in case of database overloads.
