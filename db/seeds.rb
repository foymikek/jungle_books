# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Book.destroy_all
Author.destroy_all

a_1 = Author.create(first_name: "John", last_name: "Tolkien", age: 81)
a_2 = Author.create(first_name: "Joanne", last_name: "Rowling", age: 55)

a_1.books.create(title: "The Lord of the Rings: The Fellowship of the Ring")
a_1.books.create(title: "The Lord of the Rings: The Two Towers")
a_1.books.create(title: "The Lord of the Rings: The Return of the King")

a_2.books.create(title: "Harry Potter and the Sorcerer's Stone")
a_2.books.create(title: "Harry Potter and the Chamber of Secrets")
a_2.books.create(title: "Harry Potter and the Prisoner of Azkaban")
a_2.books.create(title: "Harry Potter and the Goblet of Fire")
a_2.books.create(title: "Harry Potter and the Order of the Phoenix")
a_2.books.create(title: "Harry Potter and the Half-Blood Prince")
a_2.books.create(title: "Harry Potter and the Deathly Hallows: Part 1")
a_2.books.create(title: "Harry Potter and the Deathly Hallows: Part 2")


