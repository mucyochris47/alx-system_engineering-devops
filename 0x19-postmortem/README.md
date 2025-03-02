Impact:
Web-01 server was down, causing an outage for 85% of users.
Users experienced "504 Gateway Timeout" errors when trying to access the site.
API services relying on Web-01 were also affected.
Root Cause:
A misconfiguration in the Nginx server led to excessive memory usage, causing it to crash.
Timeline
10:00 AM UTC: Monitoring system detected increased error rates on the web server.
10:05 AM UTC: On-call engineer received an alert from UptimeRobot and began investigating.
10:15 AM UTC: Attempted to restart Nginx but it crashed again after a few minutes.
10:30 AM UTC: Checked logs and found repeated memory allocation failures.
10:45 AM UTC: Increased swap memory temporarily, but issue persisted.
11:00 AM UTC: Escalated to DevOps team for deeper analysis.
11:30 AM UTC: Identified the root cause – excessive worker processes consuming memory due to a configuration error.
12:00 PM UTC: Adjusted Nginx configuration (worker_processes set to auto instead of a fixed high number).
12:30 PM UTC: Server fully recovered and normal operations resumed.
Root Cause and Resolution
Root Cause
The Nginx configuration had an incorrect setting:
nginx
Copy
Edit
worker_processes 16;
This caused excessive memory usage, leading to a crash when memory was exhausted.
Resolution
Updated the configuration to dynamically adjust worker processes based on available CPU cores:
nginx
Copy
Edit
worker_processes auto;
Restarted the Nginx service:
bash
Copy
Edit
sudo systemctl restart nginx
Implemented memory monitoring to alert on high usage before a crash.
Corrective and Preventative Measures
Improvements
Implement proper load testing before applying configuration changes.
Enhance monitoring to detect memory issues earlier.
Improve incident response documentation.
Action Items
 Add automated alerts for high memory usage.
 Conduct a review of all Nginx configurations across servers.
 Implement auto-scaling for high-traffic periods.
 Train engineers on server performance tuning best practices.

