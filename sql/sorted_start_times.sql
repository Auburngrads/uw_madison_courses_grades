SELECT COUNT(*) 
FROM 
    (SELECT courses.name, 
        CAST(start_time AS float) / 60 AS start_time_in_hours, 
        CAST(end_time AS float) / 60 AS end_time_in_hours
    FROM schedules
    --WHERE start_time_in_hours > 0
    JOIN sections ON schedules.uuid = sections.schedule_uuid 
    JOIN course_offerings AS c ON sections.course_offering_uuid = c.uuid
    JOIN courses ON c.course_uuid = courses.uuid
    GROUP BY courses.uuid, courses.name, start_time_in_hours, end_time_in_hours
    ORDER BY start_time_in_hours ASC
    ) AS start_times_converted
WHERE start_time_in_hours BETWEEN 0 AND 12 AND name != 'null';
