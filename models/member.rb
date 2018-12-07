require_relative('../db/sql_runner')

class Member

  attr_accessor(:id, :name, :gold_membership)

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @name = options['name']
    @gold_membership = options['gold_membership']
  end

  def save()
    sql = "INSERT INTO members (name, gold_membership) VALUES ($1, $2) returning id"
    values = [@name, @gold_membership]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM members"
    members = SqlRunner.run(sql)
    result = members.map{|member| Member.new(member)}
    return result
  end

  def update()
    sql = "UPDATE members SET (name, gold_membership) = ($1, $2) WHERE id = $3"
    values = [@name, @gold_membership]
    SqlRunner.run(sql, values)
  end
  
  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
