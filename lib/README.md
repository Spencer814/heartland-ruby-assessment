# Rename Photos

This Ruby project allows you to process a list of photos by renaming them after grouping them by city and time taken.

## Description

This Ruby project provides functionality to group them by city, sort photos by their timestamps, rename them, and order them by their original index. It includes the following constants and functions:

### Constants

- `PHOTO_EXTENSIONS`: An array of valid photo file extensions.
- `CITY_NAME_REGEX`: Regular expression for validating city names.
- `DATE_REGEX`: Regular expression for validating date and time formats.
- `PHOTO_DATA_REGEX`: Regular expression for validating photo data.

### Functions

1. `sort_by_time_taken(photos)`: Sorts an array of photo strings by their time taken.
   - Input: Array of photo strings
   - Output: Array of photo strings sorted by time taken

2. `group_by_city(input)`: Groups and sorts photos by city and time taken.
   - Input: String containing a list of photos
   - Output: Hash containing the list of photos grouped by city and sorted by time taken

3. `rename_photos(hash)`: Renames grouped photos and orders them by the original index.
   - Input: Hash of grouped photos
   - Output: A string with renamed and ordered photo names

## Example

Here's an example of how to use the project:

```ruby
# This can be replaced in rename_photos.rb any string of photos with the same structure.
input = [
  'photo.jpg, Krakow, 2013-09-05 14:08:15',
  'Mike.png, London, 2015-06-20 15:13:22',
  'myFriends.png, Krakow, 2013-09-05 14:07:13',
  'Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02',
  'pisatower.jpg, Florianopolis, 2015-07-22 23:59:59',
  'BOB.jpg, London, 2015-08-05 00:02:03',
  'notredame.png, Florianopolis, 2015-09-01 12:00:00',
  'me.jpg, Krakow, 2013-09-06 15:40:22',
  'a.png, Krakow, 2016-02-13 13:33:50',
  'b.jpg, Krakow, 2016-01-02 15:12:22',
  'c.jpg, Krakow, 2016-01-02 14:34:30',
  'd.jpg, Krakow, 2016-01-02 15:15:01',
  'e.png, Krakow, 2016-01-02 09:49:09',
  'f.png, Krakow, 2016-01-02 10:55:32',
  'g.jpg, Krakow, 2016-02-29 22:13:11'
].join("\n")

hash = group_by_city(input)

puts rename_photos(hash)
# should return:
"Krakow02.jpg
London1.png
Krakow01.png
Florianopolis2.jpg
Florianopolis1.jpg
London2.jpg
Florianopolis3.png
Krakow03.jpg
Krakow09.png
Krakow07.jpg
Krakow06.jpg
Krakow08.jpg
Krakow04.png
Krakow05.png
Krakow10.jpg"
```
