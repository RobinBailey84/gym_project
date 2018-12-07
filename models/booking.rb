require_relative('../db/sql_runner')

class Booking

  attr_accessor(:id, :member_id, :gymclass_id)

def initialize(options)
  @id = options['id'].to_i if options['id']
  @member_id = options['member_id'].to_i
  @gymclass_id = options['gymclass_id'].to_i
end

def save()
  sql = "INSERT INTO bookings (member_id, gymclass_id) VALUES ($1, $2) returning id"
  values = [@member_id, @gymclass_id]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end

def self.all()
  sql = "SELECT * FROM bookings"
  bookings = SqlRunner.run(sql)
  result = bookings.map{|booking|Booking.new(booking)}
  return result
end

def self.delete_all()
  sql = "DELETE FROM bookings"
  SqlRunner.run(sql)
end

def delete()
  sql = "DELETE FROM bookings WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end






end
