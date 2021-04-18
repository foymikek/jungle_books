# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Book.destroy_all

Book.create!([
  {author: 'David Hawkins', title: 'Truth vs Falsehood'},
  {author: 'Beck & Cowan', title: 'Spiral Dynamics'},
  {author: 'Peter Rhalston', title: 'The Book of Not Knowing: Exploring the True Nature of Self, Mind, and Consciousness'}
  ])
