require("pry-byebug")

require_relative("../models/castings")
require_relative("../models/movies")
require_relative("../models/stars")
require_relative("../models/SqlRunner")

star1 = Star.new({'first_name' => 'Scarlett', 'last_name' => 'Johansson'})

star1.save()

# star1.first_name = "Scarlet"
# star1.update()
# Star.delete_all()
# star1.delete()
p Star.all()
