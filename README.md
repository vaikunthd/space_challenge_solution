# Space Travel Agent Matching – SQL Challenge

## 👩‍🚀 Problem Summary
Astra Luxury Travel needs a real-time SQL algorithm to match customers with the most suitable travel agent. Based on booking history, agent experience, and match relevance, the system should return a ranked list of agents from best to worst for a given customer profile.

## 🧠 Approach
I created a SQL query that scores each agent using:
- Booking Success Rate (30%)
- Average Revenue (20%)
- Years of Service (10%)
- Customer Service Rating (20%)
- Profile Match Similarity (20%)

I used a reusable SQL view (`agent_performance_summary`) to isolate agent performance metrics from the matching logic. This separation makes the query more readable and maintainable for real-time applications.
A final score is calculated using a weighted formula and agents are ranked accordingly.

## 📂 Files

- `schema_setup.sql`: Creates and populates the tables: `assignment_history`, `bookings`, and `space_travel_agents`
- `agent_performance_summary_view.sql`: SQL to create a reusable view summarizing agent performance metrics (assignments, success rate, revenue, etc.)
- `challenge_solution.sql`: Final query using CTEs to compute and rank agents by performance and similarity to the current customer profile
- `sample_output.txt`: Example output showing top 5 matched agents for a given customer profile
- `README.md`: Overview of the problem, my assumptions, method, and run instructions

## 🛠️ Run Instructions
1. Import `schema_setup.sql` into your SQLite environment
2. Run `challenge_solution.sql`, replacing profile filters as needed

## 🧪 Sample Inputs
```sql
-- CommunicationMethod: 'Text'
-- LeadSource: 'Organic'
-- Destination: 'Mars'
-- LaunchLocation: 'Dallas-Fort Worth Launch Complex'
