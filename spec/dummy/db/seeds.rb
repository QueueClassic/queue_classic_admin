puts "Seeding jobs"

200.times do |i|
  QC.enqueue "puts"
end
