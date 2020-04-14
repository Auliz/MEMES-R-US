
Mood.destroy_all
User.destroy_all

Mood.create(name: "happy")
Mood.create(name: "bored")
Mood.create(name: "sad")
Mood.create(name: "meh")
Mood.create(name: "still a piece of garbage")
Mood.create(name: "feelin' like a whole snack")
Mood.create(name: "ugly")
Mood.create(name: "vibes bro, just vibes")
Mood.create(name: "chillin' out maxin' relaxin' all cool")
Mood.create(name: "depressy")

User.create(name: "Joe")
User.create(name: "Haley")
User.create(name: "Stefani")
User.create(name: "Kyle")




p "Created #{Mood.count} moods from seeding"
p "Created #{User.count} users from seeding"