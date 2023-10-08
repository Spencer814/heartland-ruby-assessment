# Basic RSpec Unit Test

This document provides an overview of the RSpec tests for the Ruby project that renames a given list of photos.

## Description

This RSpec test suite focuses on verifying the functionality of the Ruby project responsible for renaming photos. The project provides three primary functions:

1. `sort_by_time_taken(photos)`: Sorts photos by their timestamps.

2. `group_by_city(input)`: Groups and sorts photos by city.

3. `rename_photos(hash)`: Renames grouped photos and orders them by the original index.

## Usage

1. Make sure you have RSpec installed in your Ruby environment.

2. Include the necessary Ruby files from the project, such as `rename_photos.rb`.

3. Run the RSpec tests to verify the correctness of the project's functions.

## Test Cases

### sort_by_time_taken

The `sort_by_time_taken` function is responsible for sorting photos by their timestamps.

- **Description:** It should sort photos based on their time taken in ascending order.

### group_by_city

The `group_by_city` function is responsible for grouping and sorting photos by city.

- **Description:** It should group photos by city and sort them based on their timestamps.

### rename_photos

The `rename_photos` function is responsible for renaming grouped photos and ordering them by the original index.

- **Description:** It should rename grouped photos and ensure they are ordered correctly by the original index.
