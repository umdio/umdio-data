# Takes an existing semester live on umd.io and exports it to JSON
require 'open-uri'
require 'json'

courses = []
n = 0

while res = open("https://api.umd.io/v0/courses?semester=#{ARGV[0]}&expand=sections&page=#{n}").read
    if res == '[]'
        break
    end

    j = JSON.parse(res)

    j.each do |course|
        courses << course
    end
    n += 1
    puts "Getting page #{n}"
end

File.open("./data/#{ARGV[0]}.json","w") do |f|
  f.write(courses.to_json)
end