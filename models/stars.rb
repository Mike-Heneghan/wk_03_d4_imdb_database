require_relative("SqlRunner")
require_relative("movies")

class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

    def initialize( options )
      @id = options['id']
      @first_name = options['first_name']
      @last_name = options['last_name']
    end

    def save()
      sql = "
      INSERT INTO stars (first_name, last_name) VALUES ($1, $2) RETURNING id
      "
      values = [@first_name, @last_name]

      result = SqlRunner.run(sql,values)
      @id = result[0]['id']

    end

    def self.all()
      sql = "
      SELECT * FROM stars;"

      result = SqlRunner.run(sql)
      star_objects = result.map { |star_hash| Star.new(star_hash) }
      return star_objects

    end

    def self.delete_all
      sql = "
      DELETE FROM stars;"

      result = SqlRunner.run(sql)
    end

    def delete()
      sql = "
      DELETE FROM stars"
      result = SqlRunner.run(sql)
    end

    def update()
      sql = "
      UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3"

      values = [@first_name, @last_name, @id]

      result = SqlRunner.run(sql, values)

    end

    def stars_movies()
      sql = "
      SELECT movies.*
      FROM movies
      INNER JOIN castings
      ON castings.movie_id = movies.id
      WHERE star_id = $1;
      "
      values = [@id]

      result = SqlRunner.run(sql, values)
      movie_objects = result.map { |movie_hash| Movie.new(movie_hash) }
    end

end
