namespace :notes do
  desc "For Notes"
  task move: :environment do
    MoveNotesServices.new.move
  end
end
