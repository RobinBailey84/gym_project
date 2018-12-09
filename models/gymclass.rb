require_relative('../db/sql_runner')

class GymClass

  attr_accessor(:id, :name, :class_date, :class_time, :capacity)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @class_date = options['class_date']
    @class_time = options['class_time']
    @capacity = options['capacity']
  end

  def save()
    sql = "INSERT INTO gymclasses (name, class_date, class_time, capacity) VALUES ($1, $2, $3, $4) returning id"
    values = [@name, @class_date, @class_time, @capacity]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM gymclasses"
    results = SqlRunner.run(sql)
    return results.map{|gymclass| GymClass.new(gymclass)}
  end

  def update()
    sql = "UPDATE gymclasses SET (name, class_date, class_time, capacity) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @class_date, @class_time, @capacity]
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

end
