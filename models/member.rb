require_relative('../db/sql_runner')

class Member

  attr_accessor(:id, :name, :gold_membership)

  def initialize(options)
    @id = options['id'].to_i if options['id']
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
    results = SqlRunner.run(sql)
    return results.map{|member| Member.new(member)}
  end

  def update()
    sql = "UPDATE members SET (name, gold_membership) = ($1, $2) WHERE id = $3"
    values = [@name, @gold_membership, @id]
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

  def self.find(id)
    sql = "SELECT * FROM members WHERE id = $1"
    values = [id]
    member = SqlRunner.run(sql, values)
    result = Member.new(member.first)
    return result
  end

  def check_membership()
    if @peak_time == true && @gold_membership == false
      return true
    end
    return false
  end

end
