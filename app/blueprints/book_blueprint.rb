class BookBlueprint < Blueprinter::Base
  identifier :id

  fields :tittle, :description, :pages, :author, :category, :thumbnail_url, :publisher, :ISBN, :published_date
end
