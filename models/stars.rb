require_relative("SqlRunner")
require_relative("movies")

class Star

  attr_accessor :first_name :last_name
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
end
