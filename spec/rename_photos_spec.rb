require 'rspec'
require 'time'

require_relative '../lib/rename_photos.rb'

RSpec.describe 'Photo Sorting and Grouping' do
  input_photos = [
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
  ]

  describe 'sort_by_time_taken' do
    it 'sorts photos by time taken' do
      sorted_photos = sort_by_time_taken(input_photos)

      # Expected order after sorting by time taken
      expected_order = [
        'myFriends.png, Krakow, 2013-09-05 14:07:13',
        'photo.jpg, Krakow, 2013-09-05 14:08:15',
        'me.jpg, Krakow, 2013-09-06 15:40:22',
        'Mike.png, London, 2015-06-20 15:13:22',
        'pisatower.jpg, Florianopolis, 2015-07-22 23:59:59',
        'Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02',
        'BOB.jpg, London, 2015-08-05 00:02:03',
        'notredame.png, Florianopolis, 2015-09-01 12:00:00',
        'e.png, Krakow, 2016-01-02 09:49:09',
        'f.png, Krakow, 2016-01-02 10:55:32',
        'c.jpg, Krakow, 2016-01-02 14:34:30',
        'b.jpg, Krakow, 2016-01-02 15:12:22',
        'd.jpg, Krakow, 2016-01-02 15:15:01',
        'a.png, Krakow, 2016-02-13 13:33:50',
        'g.jpg, Krakow, 2016-02-29 22:13:11'
      ]

      expect(sorted_photos).to eq(expected_order)
    end
  end

  describe 'group_by_city' do
    it 'groups and sorts photos by city' do
      result = group_by_city(input_photos.join("\n"))

      # Expected output after grouping and sorting
      expected_output = {
        'Florianopolis' => [
          'Florianopolis1.jpg, Florianopolis, 2015-07-22 23:59:59, 4',
          'Florianopolis2.jpg, Florianopolis, 2015-07-23 08:03:02, 3',
          'Florianopolis3.png, Florianopolis, 2015-09-01 12:00:00, 6'
        ],
        'Krakow' => [
          'Krakow01.png, Krakow, 2013-09-05 14:07:13, 2',
          'Krakow02.jpg, Krakow, 2013-09-05 14:08:15, 0',
          'Krakow03.jpg, Krakow, 2013-09-06 15:40:22, 7',
          'Krakow04.png, Krakow, 2016-01-02 09:49:09, 12',
          'Krakow05.png, Krakow, 2016-01-02 10:55:32, 13',
          'Krakow06.jpg, Krakow, 2016-01-02 14:34:30, 10',
          'Krakow07.jpg, Krakow, 2016-01-02 15:12:22, 9',
          'Krakow08.jpg, Krakow, 2016-01-02 15:15:01, 11',
          'Krakow09.png, Krakow, 2016-02-13 13:33:50, 8',
          'Krakow10.jpg, Krakow, 2016-02-29 22:13:11, 14'
        ],
        'London' => [
          'London1.png, London, 2015-06-20 15:13:22, 1',
          'London2.jpg, London, 2015-08-05 00:02:03, 5'
        ]
      }

      expect(result).to eq(expected_output)
    end
  end

  describe 'rename_photos' do
    it 'renames photos and orders them by original index' do
      grouped_photos = group_by_city(input_photos.join("\n"))

      result = rename_photos(grouped_photos)

      # Expected output after renaming and ordering
      expected_output = <<~EXPECTED
        Krakow02.jpg
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
        Krakow10.jpg
      EXPECTED

      expect(result).to eq(expected_output.strip)
    end
  end
end
