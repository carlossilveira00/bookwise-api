class UserLibraryBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :status, :started_date, :ended_date
  association :book, blueprint: BookBlueprint
end
