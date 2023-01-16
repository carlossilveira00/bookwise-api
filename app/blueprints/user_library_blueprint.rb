class UserLibraryBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :status, :started_date, :ended_date
  # Render the information of each book in each instance of UserLibrary.
  association :book, blueprint: BookBlueprint
end
