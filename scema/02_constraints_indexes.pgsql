--cant have repeated names
ALTER TABLE users
ADD CONSTRAINT unique_users_email
UNIQUE (email);

--cant leave name empty
ALTER TABLE users
ALTER COLUMN name SET NOT NULL;

--cant use a repeated email address
ALTER TABLE owners
ADD CONSTRAINT unique_owners_email
UNIQUE (email);

--an owner cant ahve a neative number of bikes
ALTER TABLE owners
ADD CONSTRAINT check_positive_bike_count
CHECK (bike_count >= 0);

--stop deleteing, bikes cant exist without an owner 
ALTER TABLE bikes
ADD CONSTRAINT fk_bikes_owner
FOREIGN KEY ("owner_id")
REFERENCES owners("owner_id")
ON DELETE RESTRICT;

--qr code is used to identify bik, must be unique 
ALTER TABLE bikes
ADD CONSTRAINT unique_bikes_qr_code
UNIQUE ("qr_code");

--a bike status can only be one of the five listed bellow  
ALTER TABLE bikes
ADD CONSTRAINT check_bikes_status
CHECK (status IN (
    'Available',
    'Rented',
    'Damaged',
    'Under Maintenance',
    'Inactive'
));

--coordinates must be limited between -90 and 90 (i dont make the rules)
ALTER TABLE bikes
ADD CONSTRAINT check_bikes_latitude
CHECK (latitude BETWEEN -90 AND 90);

--obniously the same for longitude
ALTER TABLE bikes
ADD CONSTRAINT check_bikes_longitude
CHECK (longitude BETWEEN -180 AND 180);

--trip cant exist with a user
ALTER TABLE trips
ADD CONSTRAINT fk_trips_user
FOREIGN KEY ("student_id")
REFERENCES users("student_id")
ON DELETE RESTRICT;

--trip cant exist without bike
ALTER TABLE trips
ADD CONSTRAINT fk_trips_bike
FOREIGN KEY ("bike_id")
REFERENCES bikes("bike_id")
ON DELETE RESTRICT;

--doing the same with payment method!!!!!!!!!!!!!!!!!!!!!!!!!
ALTER TABLE trips
ADD CONSTRAINT fk_trips_payment_methods
FOREIGN KEY ("card_number")
REFERENCES payment_methods("card_number")
ON DELETE RESTRICT;

--a trip status should be one of these three 
ALTER TABLE trips
ADD CONSTRAINT check_trips_status
CHECK (status IN ('Active', 'Completed', 'Cancelled'));

--dont even need to explain this one
ALTER TABLE trips
ADD CONSTRAINT check_trips_rating
CHECK (rating BETWEEN 1 AND 5);

--cost must be positive (we are not paying the users to have a trip)
ALTER TABLE trips
ADD CONSTRAINT check_trips_cost
CHECK (cost >= 0);

--distance is positive (cant break physics)
ALTER TABLE trips
ADD CONSTRAINT check_trips_distance
CHECK (distance >= 0);

--we travel in spac enot in time (trip must start then end)
ALTER TABLE trips
ADD CONSTRAINT check_trips_dates
CHECK ("end_time" IS NULL OR "end_time" >= "start_time");

--every report should have a reporter (basic common sense)
ALTER TABLE reports
ADD CONSTRAINT fk_reports_user
FOREIGN KEY ("student_id")
REFERENCES users("student_id")
ON DELETE RESTRICT;

--report cant exist without a trip (what would you be complainting about then)
ALTER TABLE reports
ADD CONSTRAINT fk_reports_trip
FOREIGN KEY ("trip_id")
REFERENCES trips("trip_id")
ON DELETE RESTRICT;

--if we fire an admin, the report should stay, however the admin row should be empty
ALTER TABLE reports
ADD CONSTRAINT fk_reports_admin
FOREIGN KEY ("admin_id")
REFERENCES admins("admin_id")
ON DELETE SET NULL;

--a report should be one of the following:
ALTER TABLE reports
ADD CONSTRAINT check_reports_status
CHECK ("status" IN (
    'Pending',
    'Under Review',
    'Resolved',
    'Rejected'
));


