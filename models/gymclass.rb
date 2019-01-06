require_relative('../db/sql_runner')
require('time')

class GymClass

  attr_accessor(:id, :name, :class_date, :class_time, :capacity, :peak_time)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @class_date = options['class_date']
    @class_time = options['class_time']
    @capacity = options['capacity'].to_i()
    @peak_time = options['peak_time']
  end

  def save()
    sql = "INSERT INTO gymclasses (name, class_date, class_time, capacity, peak_time) VALUES ($1, $2, $3, $4, $5) returning id"
    values = [@name, @class_date, @class_time, @capacity, @peak_time]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM gymclasses"
    results = SqlRunner.run(sql)
    return results.map{|gymclass| GymClass.new(gymclass)}
  end

  def update()
    sql = "UPDATE gymclasses SET (name, class_date, class_time, capacity, peak_time) = ($1, $2, $3, $4, $5) WHERE id = $6"
    values = [@name, @class_date, @class_time, @capacity, @peak_time, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM gymclasses"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM gymclasses WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM gymclasses WHERE id = $1"
    values = [id]
    gymclass = SqlRunner.run(sql, values)
    result = GymClass.new(gymclass.first)
    return result
  end

  def members()
    sql = "SELECT members.* FROM members INNER JOIN bookings ON members.id = bookings.member_id WHERE bookings.gymclass_id = $1"
    values = [@id]
    member_array = SqlRunner.run(sql, values)
    members = member_array.map{|member_hash| Member.new(member_hash)}
    return members
  end

  def check_class_is_full()
    if members().count >= @capacity
      return true
    end
    return false
  end


end
