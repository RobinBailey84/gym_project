DROP TABLE members;
DROP TABLE gymclasses;
DROP TABLE bookings;

CREATE TABLE members(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  gold_membership BOOLEAN
);

CREATE TABLE gymclasses(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  class_date VARCHAR,
  class_time FLOAT,
  capacity INTEGER
);

CREATE TABLE bookings(
  id SERIAL PRIMARY KEY,
  member_id INTEGER REFERENCES members(id) ON DELETE CASCADE,
  gymclass_id INTEGER REFERENCES gymclasses(id) ON DELETE CASCADE
);
