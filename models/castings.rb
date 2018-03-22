require("pry-byebug")

require_relative("movies")
require_relative("stars")
require_relative("SqlRunner")

class Casting

  attr_reader :id
  attr_accessor :movie_id, :star_id, :fee

  def initialize( options )
    @id = options['id']
    @movie_id = options['movie_id']
    @star_id = options['star_id']
    @fee = options['fee'].to_i
  end

  def save()
    sql = "
    INSERT INTO castings (movie_id, star_id, fee) VALUES ($1, $2, $3) RETURNING id;"

    values = [@movie_id, @star_id, @fee]

    result = SqlRunner.run(sql, values)
    @id = result[0]['id']

  end

  def self.all()
    sql = "
    SELECT * FROM castings"

    result = SqlRunner.run(sql)
    casting_objects = result.map { |casting_hash| Casting.new(casting_hash) }
    return casting_objects
  end

  def self.delete_all()
    sql = "
    DELETE FROM castings"

    result = SqlRunner.run(sql)
  end

  def delete()
    sql = "
    DELETE FROM castings"
    result = SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE castings SET (movie_id, star_id, fee) = ($1, $2, $3) WHERE id = $4"

    values = [@movie_id, @star_id, @fee, @id]

    result = SqlRunner.run(sql, values)

  end
end
