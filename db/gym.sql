DROP TABLE bookings;
DROP TABLE members;
DROP TABLE gymclasses;


CREATE TABLE members(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  gold_membership BOOLEAN
);

CREATE TABLE gymclasses(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  class_date DATE,
  class_time TIME,
  capacity INTEGER,
  peak_time BOOLEAN
);

CREATE TABLE bookings(
  id SERIAL PRIMARY KEY,
  member_id INTEGER REFERENCES members(id) ON DELETE CASCADE,
  gymclass_id INTEGER REFERENCES gymclasses(id) ON DELETE CASCADE
);
