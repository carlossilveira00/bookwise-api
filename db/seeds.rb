require "json";
require "open-uri";

categories = ['Adult', 'Anthologies', 'Art', 'Biographies', 'Body', 'Business', 'Children', 'Comics', 'Cooking', ' Contemporary', 'Crime', 'Engineering', 'Entertainment', 'Fantasy', 'Fiction', 'Food', 'General', 'Health', 'History', 'Horror', 'Investing', 'Literature', 'Media-help', 'Memoirs', 'Mystery', 'Nonfiction', 'Religion', 'Romance', 'Science', 'Sports', 'Superheroes', 'Technology', 'Thrillers', 'Travel', 'Young']


categories.each do |category|
  url = "https://www.googleapis.com/books/v1/volumes?q=subject:#{category}&maxResults=40"
  books_serialized = URI.open(url).read
  books = JSON.parse(books_serialized)

  books['items'].each do |book|
    unless book['volumeInfo']['industryIdentifiers'].nil?
      Book.create!({
        title: book['volumeInfo']['title'],
        description: book['volumeInfo']['description'],
        pages: book['volumeInfo']['pageCount'],
        author: book['volumeInfo']['authors'][0],
        category: book['volumeInfo']['categories'][0],
        thumbnail_url: book['volumeInfo']['imageLinks']['thumbnail'],
        publisher: book['volumeInfo']['publisher'],
        ISBN: book['volumeInfo']['industryIdentifiers'][0]['identifier'],
        published_date: book['volumeInfo']['publishedDate'],
        rating: book['volumeInfo']['averageRating']
      })
    end
  end
  puts "Completed category: #{category}"
end
