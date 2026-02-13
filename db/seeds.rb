# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "🌱 Seeding West Loop schedule (real data)..."

StudioClass.delete_all
studio = Studio.first_or_create!(name: "West Loop")

classes = [
  # Mon, Feb 16
  ["2026-02-16", "06:00", "CorePower Yoga 2", "Eleanor N", 60],
  ["2026-02-16", "06:00", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-16", "06:30", "CorePower Strength X (Lower Body)", "Marqui M", 45],
  ["2026-02-16", "07:15", "Yoga Sculpt", "Meghan D", 60],
  ["2026-02-16", "07:15", "CorePower Yoga 2", "Eleanor N", 60],
  ["2026-02-16", "08:30", "CorePower Yoga 2", "Stephanie F", 60],
  ["2026-02-16", "10:00", "CorePower Yoga 2", "Ivy C", 60],
  ["2026-02-16", "10:00", "Yoga Sculpt", "Sameera A", 60],
  ["2026-02-16", "11:30", "CorePower Strength X (Lower Body)", "Sameera A", 45],
  ["2026-02-16", "12:00", "CorePower Yoga 2", "Ivy C", 60],
  ["2026-02-16", "12:30", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-16", "13:30", "Hot Power Fusion", "Faz P", 60],
  ["2026-02-16", "14:00", "Yoga Sculpt", "Sameera A", 60],
  ["2026-02-16", "15:30", "CorePower Strength X (Lower Body)", "Alycia Me", 45],
  ["2026-02-16", "16:00", "CorePower Yoga 2", "Jim P", 60],
  ["2026-02-16", "16:45", "Yoga Sculpt", "Samantha F", 60],
  ["2026-02-16", "17:30", "CorePower Yoga 2", "Jim P", 60],
  ["2026-02-16", "18:00", "Yoga Sculpt", "Emma J", 60],
  ["2026-02-16", "19:00", "CorePower Yoga 2", "Jessica S", 60],
  ["2026-02-16", "19:15", "Unheated Pre & Post Natal Flow", "Erin F", 60],
  ["2026-02-16", "19:15", "Yoga Sculpt", "Kathryn K", 60],
  ["2026-02-16", "20:30", "Yoga Sculpt", "Meghan D", 60],
  ["2026-02-16", "20:45", "Hot Power Fusion: Candlelight", "Erin F", 60],

  # Tue, Feb 17
  ["2026-02-17", "05:45", "CorePower Yoga 2", "Eleanor N", 60],
  ["2026-02-17", "06:00", "Yoga Sculpt", "Dani S", 60],
  ["2026-02-17", "06:30", "Yoga Sculpt: Low Heat", "Taylor G", 60],
  ["2026-02-17", "07:15", "Yoga Sculpt", "Cassidy S", 60],
  ["2026-02-17", "07:15", "Hot Power Fusion", "Eleanor N", 60],
  ["2026-02-17", "08:30", "Yoga Sculpt", "Samantha F", 60],
  ["2026-02-17", "08:30", "CorePower Yoga 2", "Amina G", 60],
  ["2026-02-17", "10:00", "CorePower Yoga 2", "Jose Carlo C", 60],
  ["2026-02-17", "10:00", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-17", "12:00", "CorePower Yoga 2", "Jose Carlo C", 60],
  ["2026-02-17", "12:30", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-17", "13:30", "Hot Power Fusion", "Faz P", 60],
  ["2026-02-17", "15:30", "CorePower Strength X (Upper Body)", "Jim P", 45],
  ["2026-02-17", "16:00", "CorePower Yoga 2", "Jose Carlo C", 60],
  ["2026-02-17", "16:45", "Yoga Sculpt", "Bridget K", 60],
  ["2026-02-17", "17:30", "CorePower Yoga 2: Candlelight", "Amy G", 60],
  ["2026-02-17", "18:00", "Yoga Sculpt", "Sameera A", 60],
  ["2026-02-17", "19:00", "CorePower Yoga 2: 75 mins-Candlelight", "Jose Carlo C", 75],
  ["2026-02-17", "19:15", "Yoga Sculpt", "Amy G", 60],
  ["2026-02-17", "20:30", "Yoga Sculpt", "Emily F", 60],

  # Wed, Feb 18
  ["2026-02-18", "05:45", "CorePower Yoga 2", "Eleanor N", 60],
  ["2026-02-18", "06:00", "Yoga Sculpt", "Mandy M", 60],
  ["2026-02-18", "06:30", "CorePower Strength X (Full Body)", "Cassidy S", 45],
  ["2026-02-18", "07:15", "Yoga Sculpt", "McKenna P", 60],
  ["2026-02-18", "07:15", "CorePower Yoga 2", "Eleanor N", 60],
  ["2026-02-18", "08:30", "CorePower Yoga 2", "Amina G", 60],
  ["2026-02-18", "08:30", "Yoga Sculpt", "Em H", 60],
  ["2026-02-18", "10:00", "CorePower Yoga 2 (Assist & Adjust)", "Bridgette V", 60],
  ["2026-02-18", "16:00", "CorePower Yoga 2", "Annette O", 60],
  ["2026-02-18", "16:45", "Yoga Sculpt", "Bridget K", 60],
  ["2026-02-18", "17:30", "CorePower Yoga 2", "Miguel S", 60],
  ["2026-02-18", "18:00", "Yoga Sculpt", "Eleanor N", 60],
  ["2026-02-18", "18:15", "CorePower Yoga 2: Low Heat", "Lauren L", 60],
  ["2026-02-18", "19:00", "CorePower Yoga 2: Candlelight", "Monica S", 60],
  ["2026-02-18", "19:15", "Yoga Sculpt", "Paige Ad", 60],
  ["2026-02-18", "19:30", "CorePower Yoga 1", "Anna E", 60],
  ["2026-02-18", "20:30", "Yoga Sculpt", "Sophia G", 60],
  ["2026-02-18", "20:30", "Hot Power Fusion", "Erin F", 60],

    # Thu, Feb 19
  ["2026-02-19", "06:00", "CorePower Yoga 2", "Megan N", 60],
  ["2026-02-19", "06:00", "Yoga Sculpt", "Emma J", 60],
  ["2026-02-19", "06:30", "CorePower Strength X (Glutes + Core)", "Marqui M", 45],
  ["2026-02-19", "07:15", "Hot Power Fusion", "Eleanor N", 60],
  ["2026-02-19", "07:15", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-19", "08:30", "Yoga Sculpt", "Samantha F", 60],
  ["2026-02-19", "08:30", "CorePower Yoga 2", "Stephanie F", 60],
  ["2026-02-19", "10:00", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-19", "10:00", "CorePower Yoga 2", "Kristin D", 60],
  ["2026-02-19", "11:30", "CorePower Strength X (Glutes + Core)", "Danielle H", 45],
  ["2026-02-19", "12:00", "CorePower Yoga 2", "Kristin D", 60],
  ["2026-02-19", "12:30", "Yoga Sculpt", "Danielle H", 60],
  ["2026-02-19", "13:30", "Hot Power Fusion", "Faz P", 60],
  ["2026-02-19", "14:00", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-19", "15:30", "CorePower Strength X (Glutes + Core)", "Gillian F", 45],
  ["2026-02-19", "16:00", "CorePower Yoga 2", "Dave Y", 60],
  ["2026-02-19", "16:45", "Yoga Sculpt", "Donnie A", 60],
  ["2026-02-19", "17:30", "CorePower Yoga 3", "Dave Y", 60],
  ["2026-02-19", "18:00", "Yoga Sculpt", "Anna E", 60],
  ["2026-02-19", "19:15", "Yoga Sculpt", "Anna E", 60],
  ["2026-02-19", "19:15", "CorePower Yoga 2", "Dave Y", 60],
  ["2026-02-19", "20:30", "Yoga Sculpt", "Sophia G", 60],
  ["2026-02-19", "20:45", "Hot Power Fusion", "Dave Y", 60],

    # Fri, Feb 20
  ["2026-02-20", "06:00", "Yoga Sculpt - Low Heat", "Gillian F", 60],
  ["2026-02-20", "06:00", "CorePower Yoga 2", "Jessica S", 60],
  ["2026-02-20", "07:15", "CorePower Yoga 2", "Jessica S", 60],
  ["2026-02-20", "07:15", "Yoga Sculpt", "Robert C", 60],
  ["2026-02-20", "08:30", "Yoga Sculpt", "Mandy M", 60],
  ["2026-02-20", "09:30", "CorePower Strength X (Full Body)", "Kristin D", 45],
  ["2026-02-20", "10:00", "CorePower Yoga 2", "Laurie S", 60],
  ["2026-02-20", "11:30", "CorePower Strength X (Full Body)", "Kristin D", 45],
  ["2026-02-20", "12:00", "CorePower Yoga 2", "Laurie S", 60],
  ["2026-02-20", "14:00", "CorePower Yoga 2", "Jose Carlo C", 60],
  ["2026-02-20", "15:30", "CorePower Strength X (Full Body)", "Gillian F", 45],
  ["2026-02-20", "16:00", "CorePower Yoga 2", "Megan N", 60],
  ["2026-02-20", "16:45", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-20", "17:30", "CorePower Yoga 2", "Megan N", 60],
  ["2026-02-20", "18:15", "Yoga Sculpt", "Michael V", 60],
  ["2026-02-20", "19:30", "Yoga Sculpt", "Robert C", 60],

    # Sat, Feb 21
  ["2026-02-21", "06:45", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-21", "07:15", "CorePower Yoga 2", "Jessica S", 60],
  ["2026-02-21", "08:00", "Yoga Sculpt", "Emma J", 60],
  ["2026-02-21", "08:30", "Hot Power Fusion", "Breanna F", 60],
  ["2026-02-21", "08:45", "CorePower Yoga 2: Low Heat", "Jessica S", 60],
  ["2026-02-21", "09:30", "Yoga Sculpt", "Gina G", 60],
  ["2026-02-21", "10:00", "CorePower Yoga 1", "Breanna F", 60],
  ["2026-02-21", "10:15", "CorePower Yoga 2 (75 min)", "Monica S", 75],
  ["2026-02-21", "11:00", "Yoga Sculpt", "Sabrina M", 60],
  ["2026-02-21", "11:45", "Hot Power Fusion", "Erin F", 60],
  ["2026-02-21", "13:00", "Yoga Sculpt", "Em H", 60],
  ["2026-02-21", "14:30", "Hot Power Fusion", "Erin F", 60],
  ["2026-02-21", "16:00", "Hot Power Fusion", "Erin F", 60],
  ["2026-02-21", "16:00", "Yoga Sculpt", "Gillian F", 60],
  ["2026-02-21", "17:15", "CorePower Yoga 2", "Laura Y", 60],
  ["2026-02-21", "17:30", "Yoga Sculpt", "Mary B", 60],
  ["2026-02-21", "19:00", "CorePower Yoga 2", "Laura Y", 60],
  ["2026-02-21", "19:00", "Yoga Sculpt", "Mary B", 60],

    # Sun, Feb 22
  ["2026-02-22", "06:45", "Yoga Sculpt (45 min)", "Emily M", 45],
  ["2026-02-22", "07:00", "CorePower Yoga 2", "Stephanie F", 60],
  ["2026-02-22", "08:00", "Yoga Sculpt", "Emily M", 60],
  ["2026-02-22", "08:15", "Hot Power Fusion", "Breanna F", 60],
  ["2026-02-22", "09:30", "Yoga Sculpt", "Akshita S", 60],
  ["2026-02-22", "09:45", "CorePower Yoga 2", "Breanna F", 60],
  ["2026-02-22", "10:00", "CorePower Yoga 1", "Tyrese B", 60],
  ["2026-02-22", "11:00", "Yoga Sculpt", "Dani S", 60],
  ["2026-02-22", "11:15", "Free Community Flow (Heated)", "Breanna F", 60],
  ["2026-02-22", "13:00", "Yoga Sculpt", "Amy H", 60],
  ["2026-02-22", "13:00", "CorePower Yoga 2", "Linnea B", 60],
  ["2026-02-22", "14:30", "Yoga Sculpt", "Amy H", 60],
  ["2026-02-22", "14:30", "CorePower Yoga 2", "Linnea B", 60],
  ["2026-02-22", "16:00", "Yoga Sculpt", "Tytiana W", 60],
  ["2026-02-22", "16:30", "CorePower Yoga 2", "Joshua K", 60],
  ["2026-02-22", "17:30", "Yoga Sculpt", "Tytiana W", 60],
  ["2026-02-22", "18:00", "CoreRestore", "Joshua K", 60],
  ["2026-02-22", "19:00", "Yoga Sculpt", "Allison R", 60],
  ["2026-02-22", "19:00", "CorePower Yoga 2", "Jessica S", 60],
  ["2026-02-22", "20:30", "Yoga Sculpt", "Allison R", 60],
]
classes.each do |date_str, time_str, class_name, instructor, dur_min|
  start_dt = Time.zone.parse("#{date_str} #{time_str}")

  StudioClass.create!(
    studio_id: studio.id,
    class_name: class_name,
    instructor: instructor,
    start_dt: start_dt,
    end_dt: start_dt + dur_min.minutes,
    difficulty: "all_levels",
    modality: "in_studio",
    source_url: "manual_copy",
    scraped_at: Time.zone.now
  )
end

puts "✅ Seeded #{StudioClass.count} West Loop classes"
