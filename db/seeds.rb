
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

User.create(name: "Joe Auz")
User.create(name: "Haley Rodzos")
User.create(name: "Stefani Waddell")
User.create(name: "Kyle Bradley")




p "Created #{Mood.count} moods from seeding"
p "Created #{User.count} users from seeding"