require_relative("../models/member.rb")
require_relative("../models/gymclass.rb")
require_relative("../models/booking.rb")

require("pry-byebug")

Member.delete_all()
GymClass.delete_all()
Booking.delete_all()

member1 = Member.new({
  "name" => "John Smith",
  "gold_membership" => false
  })
  member1.save()

  gymclass1 = GymClass.new({
    "name" => "Yoga",
    "class_date" => "20/12/2018",
    "class_time" => 15.00,
    "capacity" => 10
    })
  gymclass1.save()

    booking1 = Booking.new({
      "member_id" => member1.id,
      "gymclass_id" => gymclass1.id
      })
    booking1.save()

      binding.pry
      nil
