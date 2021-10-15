require 'bundler/inline'

gemfile do
  gem 'countries', :path => './'
end

require 'countries/global'
require 'countries/version'
require 'json'
require 'set'

puts Countries::VERSION

alpha_2_codes = ['US', 'IC', 'VA', 'TW', 'KP', 'KR', 'MK', 'SZ']

output = alpha_2_codes.each_with_object({}) do |code, results|
  begin
    c = Country[code]
    list = [c.name]
    # list.push(c.translations['en']) unless c.translations['en'].nil?
    results[code] = list.to_set.to_a
  rescue => error
    puts error
    puts "Unsupported: #{code}"
  end
end

pp output

exit

final_output = {
  "info": {
    "name": "CS countries_gem",
    "version": Countries::VERSION,
    "created_on": Time.now.utc,
    "count": output.length
  },
  "data": output
}.freeze

bytes_written = File.write 'coupa_countries_gem.json', JSON.pretty_generate(final_output)

puts "bytes_written: #{bytes_written}"


puts "**** find USA"
country = Country.find_country_by_alpha3('USA')
pp country

puts "**** find US"

country = Country.find_country_by_alpha2('US')
pp country

