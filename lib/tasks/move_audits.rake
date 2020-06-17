namespace :move_audits do
  desc "For Audits to Logs"
  task move: :environment do
    MoveAuditsServices.new.move
  end
end
