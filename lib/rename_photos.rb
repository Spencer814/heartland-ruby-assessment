require 'time'

# Constants
PHOTO_EXTENSIONS = %w[jpg png jpeg].freeze
CITY_NAME_REGEX = /[A-Z][a-z]{0,19}/.freeze
DATE_REGEX = /20(0[0-9]|1[0-9]|20)-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/.freeze
PHOTO_DATA_REGEX = Regexp.new(/^[a-zA-Z]{0,20}\.(jpg|png|jpeg), #{CITY_NAME_REGEX}, #{DATE_REGEX}$/).freeze

# Sort photos by time taken
#
# @param photos [Array] Array of photo strings.
# @return [Array] Array of photo strings sorted by time taken.
def sort_by_time_taken(photos)
  photos.sort_by { |photo| DateTime.parse(photo.split(', ')[2]) }
end

# Group photos by city
#
# @param input [String] String containing the list of photos.
# @return [Hash] Hash containing the list of photos grouped by city and sorted by time taken.
def group_by_city(input)
  # Split input string by newline characters to create array of photos
  photos = input.split("\n")

  # Validate photos before processing to avoid errors and ensure data integrity.
  valid_photos = photos.select { |photo| photo.match?(PHOTO_DATA_REGEX) }.map.with_index { |photo, index| "#{photo}, #{index}" }

  # Group photos by city and sort by time taken
  grouped_photos = valid_photos.group_by { |photo| photo.split(', ')[1] }.transform_values { |photos| sort_by_time_taken(photos) }

  # Rename photos in each group
  grouped_photos.each do |city, photos|
    # Determine the length of the largest number in the group
    max_number_length = photos.length.to_s.length

    # Create a new array of renamed photos
    renamed_photos = photos.map.with_index do |photo, index|
      photo_parts = photo.split(', ')
      number = (index + 1).to_s.rjust(max_number_length, '0')
      new_name = "#{city}#{number}.#{photo_parts[0].split('.').last}"
      "#{new_name}, #{photo_parts[1]}, #{photo_parts[2]}, #{photo_parts[3]}"
    end

    # Replace the original array with the renamed array
    grouped_photos[city] = renamed_photos
  end

  grouped_photos
end

# Convert hash of photos to array of photo strings, sort by time taken, and map to new names
def rename_photos(hash)
  # Flatten hash into array of photo strings
  photos = hash.flat_map { |city, photos| photos }

  # Sort photos by time taken
  sorted_photos = sort_by_time_taken(photos)

  # Map each photo to its new name with the original index appended
  sorted_photos.map.with_index do |photo, index|
    photo_parts = photo.split(', ')
    number = (index + 1).to_s.rjust(2, '0')
    "#{photo_parts[1]}#{number}.#{photo_parts[0].split('.').last}, #{photo_parts[3]}"
  end

  # Return array of photo strings ordered by their original index
  sorted_photos.sort_by { |photo| photo.split(', ')[3].to_i }.map { |photo| photo.split(', ')[0] }.join("\n")
end

# # Example usage
# input = [
#   'photo.jpg, Krakow, 2013-09-05 14:08:15',
#   'Mike.png, London, 2015-06-20 15:13:22',
#   'myFriends.png, Krakow, 2013-09-05 14:07:13',
#   'Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02',
#   'pisatower.jpg, Florianopolis, 2015-07-22 23:59:59',
#   'BOB.jpg, London, 2015-08-05 00:02:03',
#   'notredame.png, Florianopolis, 2015-09-01 12:00:00',
#   'me.jpg, Krakow, 2013-09-06 15:40:22',
#   'a.png, Krakow, 2016-02-13 13:33:50',
#   'b.jpg, Krakow, 2016-01-02 15:12:22',
#   'c.jpg, Krakow, 2016-01-02 14:34:30',
#   'd.jpg, Krakow, 2016-01-02 15:15:01',
#   'e.png, Krakow, 2016-01-02 09:49:09',
#   'f.png, Krakow, 2016-01-02 10:55:32',
#   'g.jpg, Krakow, 2016-02-29 22:13:11'
# ].join("\n")

# hash = group_by_city(input)

# puts rename_photos(hash)
