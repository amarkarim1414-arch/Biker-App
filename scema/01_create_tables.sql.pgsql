
CREATE TABLE users (
    "student_id" VARCHAR(8) PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    "email" VARCHAR(50) NOT NULL UNIQUE,
    "phone" VARCHAR(11) UNIQUE,
    "verified" BOOLEAN,
    CHECK (LENGTH("student_id") = 8)
);


CREATE TABLE admins (
    "admin_id" SERIAL PRIMARY KEY,
    "user_name" VARCHAR(50) NOT NULL UNIQUE,
    "phone_number" VARCHAR(11) UNIQUE
);


CREATE TABLE owners (
    "owner_id" SERIAL PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    "email" VARCHAR(50) NOT NULL UNIQUE,
    "phone" VARCHAR(11) UNIQUE,
    "bike_count" INT,
    CHECK (LENGTH("phone") = 11)
);


CREATE TABLE bikes (
    "bike_id" SERIAL PRIMARY KEY,
    "owner_id" INT NOT NULL,
    "qr_code" VARCHAR(50) NOT NULL UNIQUE,
    "model" VARCHAR(50) NOT NULL,
    "status" VARCHAR(20) NOT NULL DEFAULT 'Available',
    "latitude" DECIMAL(9,6),
    "longitude" DECIMAL(9,6),

    FOREIGN KEY ("owner_id")
        REFERENCES owners("owner_id")
        ON DELETE RESTRICT,

    CHECK ("status" IN ('Available', 'Rented', 'Damaged', 'Under Maintenance', 'Inactive')),
    CHECK ("latitude" IS NULL OR "latitude" BETWEEN -90 AND 90),
    CHECK ("longitude" IS NULL OR "longitude" BETWEEN -180 AND 180)
);


CREATE TABLE "payment_methods" (
    "card_number" VARCHAR(16) PRIMARY KEY,
    "student_id" VARCHAR(8) NOT NULL,

    FOREIGN KEY ("student_id")
        REFERENCES users("student_id")
        ON DELETE RESTRICT
);


CREATE TABLE trips (
    "trip_id" SERIAL PRIMARY KEY,
    "student_id" VARCHAR(8) NOT NULL,
    "bike_id" INT NOT NULL,
    "card_number" VARCHAR(16) REFERENCES "payment_methods"("card_number"),
    "status" VARCHAR(20) NOT NULL DEFAULT 'Active',
    "start_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "end_time" TIMESTAMP,
    "cost" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "distance" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "rating" INT,
    "review" VARCHAR(200),

    FOREIGN KEY ("student_id")
        REFERENCES users("student_id")
        ON DELETE RESTRICT,

    FOREIGN KEY ("bike_id")
        REFERENCES bikes("bike_id")
        ON DELETE RESTRICT,

    FOREIGN KEY ("card_number")
        REFERENCES "payment_methods"("card_number")
        ON DELETE RESTRICT,

    CHECK ("status" IN ('Active', 'Completed', 'Cancelled')),
    CHECK ("cost" >= 0),
    CHECK ("distance" >= 0),
    CHECK ("rating" IS NULL OR "rating" BETWEEN 1 AND 5),
    CHECK ("end_time" IS NULL OR "end_time" >= "start_time")
);


CREATE TABLE reports (
    "report_id" SERIAL PRIMARY KEY,
    "student_id" VARCHAR(8) NOT NULL,
    "trip_id" INT NOT NULL,
    "admin_id" INT,
    "description" VARCHAR(200) NOT NULL,
    "status" VARCHAR(20) NOT NULL DEFAULT 'Pending',

    FOREIGN KEY ("student_id")
        REFERENCES users("student_id")
        ON DELETE RESTRICT,

    FOREIGN KEY ("trip_id")
        REFERENCES trips("trip_id")
        ON DELETE RESTRICT,

    FOREIGN KEY ("admin_id")
        REFERENCES admins("admin_id")
        ON DELETE SET NULL,

    CHECK ("status" IN ('Pending', 'Under Review', 'Resolved', 'Rejected'))
);


SELECT * FROM users;
SELECT * FROM admins;
SELECT * FROM owners;
SELECT * FROM bikes;
SELECT * FROM "payment_methods";
SELECT * FROM trips;
SELECT * FROM reports;




