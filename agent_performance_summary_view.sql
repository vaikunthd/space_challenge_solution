DROP VIEW IF EXISTS agent_performance_summary;

CREATE VIEW agent_performance_summary AS
SELECT 
    sta.AgentID,
    COUNT(DISTINCT ah.AssignmentID) AS total_assigned,
    SUM(CASE WHEN b.BookingStatus = 'Confirmed' THEN 1 ELSE 0 END) AS successful_bookings,
    AVG(CASE WHEN b.BookingStatus = 'Confirmed' THEN b.TotalRevenue ELSE NULL END) AS avg_total_revenue,
    sta.YearsOfService,
    sta.AverageCustomerServiceRating
FROM space_travel_agents sta
LEFT JOIN assignment_history ah ON sta.AgentID = ah.AgentID
LEFT JOIN bookings b ON ah.AssignmentID = b.AssignmentID
GROUP BY sta.AgentID;
