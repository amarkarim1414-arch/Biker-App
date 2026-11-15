-- 1. users (student_id must be 8 characters; phone unique)
INSERT INTO users ("student_id", "name", "email", "phone", "verified") VALUES
    ('20230001', 'Layla Hassan', 'layla.hassan@example.edu', '01012345601', TRUE),
    ('20230002', 'Omar Farouk', 'omar.farouk@example.edu', '01012345602', TRUE),
    ('20230003', 'Nour El-Din', 'nour.eldin@example.edu', '01012345603', FALSE);

-- 2. admins (admin_id generated as 1, 2, 3 via SERIAL)
INSERT INTO admins ("user_name", "phone_number") VALUES
    ('admin_sara', '01112345601'),
    ('admin_tarek', '01112345602'),
    ('admin_mona', '01112345603');

-- 3. owners (owner_id generated as 1, 2, 3 via SERIAL; phone must be 11 characters)
INSERT INTO owners ("name", "email", "phone", "bike_count") VALUES
    ('Campus Mobility Co.', 'fleet@campusmobility.example', '01212345601', 15),
    ('GreenRide Partners', 'ops@greenride.example', '01212345602', 10),
    ('MetroCycle Egypt', 'support@metrocycle.example', '01212345603', 8);

-- 4. bikes (bike_id generated as 1, 2, 3 via SERIAL)
INSERT INTO bikes ("owner_id", "qr_code", "model", "status", "latitude", "longitude") VALUES
    (1, 'QR-BIKE-1001', 'UrbanCruiser X1', 'Available', 30.028500, 31.491300),
    (2, 'QR-BIKE-1002', 'Campus commuter V2', 'Rented', 30.031200, 31.495800),
    (3, 'QR-BIKE-1003', 'EcoStep Lite', 'Under Maintenance', 30.025400, 31.488900);

-- 5. payment_methods (card_number up to 16 chars)
INSERT INTO "payment_methods" ("card_number", "student_id") VALUES
    ('4111111111111111', '20230001'),
    ('5500000000000004', '20230002'),
    ('4242424242424242', '20230003');

-- 6. trips (trip_id generated as 1, 2, 3 via SERIAL)
INSERT INTO trips (
    "student_id", "bike_id", "card_number", "status",
    "start_time", "end_time", "cost", "distance", "rating", "review"
) VALUES
    (
        '20230001', 1, '4111111111111111', 'Completed',
        '2026-11-15 08:15:00', '2026-11-15 08:40:00', 25.00, 4.20, 5,
        'Smooth ride and bike was in great shape.'
    ),
    (
        '20230002', 2, '5500000000000004', 'Active',
        '2026-11-15 18:50:00', NULL, 0.00, 1.15, NULL,
        NULL
    ),
    (
        '20230003', 3, '4242424242424242', 'Cancelled',
        '2026-11-14 12:00:00', '2026-11-14 12:03:00', 0.00, 0.00, 2,
        'Brake felt loose right after unlocking.'
    );

-- 7. reports (report_id generated as 1, 2, 3 via SERIAL)
INSERT INTO reports ("student_id", "trip_id", "admin_id", "description", "status") VALUES
    ('20230003', 3, 1, 'Front brake lever had almost no resistance before starting trip.', 'Resolved'),
    ('20230001', 1, 2, 'Rear tire pressure seemed slightly low at drop-off.', 'Under Review'),
    ('20230002', 2, NULL, 'Bell is rattling loudly while riding.', 'Pending');