class BookBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :description, :pages, :author, :category, :thumbnail_url, :publisher, :ISBN, :published_date
end
