require("pry-byebug")

require_relative("SqlRunner")
require_relative("stars")

class Movie

  attr_reader :id
  attr_accessor :title, :genre, :rating

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @genre = options['genre']
    @rating = options['rating'].to_i
  end

  def save()
    sql = "
    INSERT INTO movies (title, genre, rating) VALUES ($1, $2, $3) returning id
    "
    values = [@title, @genre, @rating]

    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def self.all()
    sql = "
    SELECT * FROM movies"

    result = SqlRunner.run(sql)
    movie_objects = result.map { |movie_hash| Movie.new(movie_hash) }
    return movie_objects
  end

  def self.delete_all()
    sql = "
    DELETE FROM movies"

    result = SqlRunner.run(sql)

  end

  def delete()
    sql = "
    DELETE FROM movies"
    result = SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE movies SET (title, genre, rating) = ($1, $2, $3) WHERE id = $4"

    values = [@title, @genre, @rating, @id]

    result = SqlRunner.run(sql, values)

  end

  def movie_star()
    sql = "
    SELECT stars.*
    FROM stars
    INNER JOIN castings
    ON castings.star_id = stars.id
    WHERE movie_id = $1;"

      values = [@id]
    # Find the artist object based on the star_id using castings as the bridge.
    result = SqlRunner.run(sql, values)
    movie_star_object = result.map { |star| Star.new(star)  }

  end

end
