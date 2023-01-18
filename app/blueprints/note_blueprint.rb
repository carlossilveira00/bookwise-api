class NoteBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :body, :tag
  association :user_library, blueprint: UserLibraryBlueprint
end
