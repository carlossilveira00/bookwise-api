require "json"
require "open-uri"

url = "https://www.googleapis.com/books/v1/volumes?q=subject:science&maxResults=40"
user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)

user["items"].each do |book|
  # p book['volumeInfo']
  # p "********"
  # p book['volumeInfo']['title']
  # p "********"
  # p book['volumeInfo']['description']
  # p "********"
  # p book['volumeInfo']['publisher']
  # p "********"
  # p book['volumeInfo']['authors'][0]
  # p "********"
  p book['volumeInfo']['industryIdentifiers']
  p "----------------------"
end
# https://www.googleapis.com/books/v1/volumes?q=subject:self-help
