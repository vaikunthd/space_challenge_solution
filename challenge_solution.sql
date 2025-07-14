WITH similarity_scores AS (
    SELECT 
        ah.AgentID,
        SUM(CASE WHEN ah.CommunicationMethod = 'Text' THEN 1 ELSE 0 END) AS comm_match,
        SUM(CASE WHEN ah.LeadSource = 'Organic' THEN 1 ELSE 0 END) AS lead_match,
        SUM(CASE WHEN b.Destination = 'Mars' THEN 1 ELSE 0 END) AS dest_match,
        SUM(CASE WHEN b.LaunchLocation = 'Dallas-Fort Worth Launch Complex' THEN 1 ELSE 0 END) AS launch_match
    FROM assignment_history ah
    LEFT JOIN bookings b ON ah.AssignmentID = b.AssignmentID
    GROUP BY ah.AgentID
)

SELECT 
    aps.AgentID,
    sta.FirstName || ' ' || sta.LastName AS AgentName,
    aps.successful_bookings * 1.0 / NULLIF(aps.total_assigned, 0) AS success_rate,
    IFNULL(aps.avg_total_revenue, 0) AS avg_revenue,
    aps.YearsOfService,
    aps.AverageCustomerServiceRating,
    (ss.comm_match + ss.lead_match + ss.dest_match + ss.launch_match) AS profile_match_score,
    (
        (aps.successful_bookings * 1.0 / NULLIF(aps.total_assigned, 0)) * 0.3 +
        (IFNULL(aps.avg_total_revenue, 0) / 200000.0) * 0.2 +
        (aps.YearsOfService / 20.0) * 0.1 +
        (aps.AverageCustomerServiceRating / 5.0) * 0.2 +
        ((ss.comm_match + ss.lead_match + ss.dest_match + ss.launch_match) / 10.0) * 0.2
    ) AS final_score
FROM agent_performance_summary aps
JOIN space_travel_agents sta ON aps.AgentID = sta.AgentID
LEFT JOIN similarity_scores ss ON aps.AgentID = ss.AgentID
ORDER BY final_score DESC
LIMIT 5;
