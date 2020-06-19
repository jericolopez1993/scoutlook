namespace :move_audits do
  desc "For Audits to Logs"
  task move: :environment do
    MoveAuditsServices.new.move
  end

  task update_description: :environment do
    MoveAuditsServices.new.update_description
  end
end
