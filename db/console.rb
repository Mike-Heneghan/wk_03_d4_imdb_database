require("pry-byebug")

require_relative("../models/castings")
require_relative("../models/movies")
require_relative("../models/stars")
require_relative("../models/SqlRunner")

Casting.delete_all()
Movie.delete_all()
Star.delete_all()


star1 = Star.new({'first_name' => 'Scarlett', 'last_name' => 'Johansson'})

star1.save()

# star1.first_name = "Scarlet"
# star1.update()
# Star.delete_all()
# star1.delete()
p Star.all()
puts ""

movie1 = Movie.new({ 'title' => 'Ghost in the Shell', 'genre' => 'Science Fiction', 'rating' => '6'})

movie1.save()

movie1.rating = '7'
movie1.update()
p Movie.all()
puts ""

casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => '1000000'})

casting1.save()
casting1.fee = '2000000'
casting1.update()

p Casting.all()
puts ""
