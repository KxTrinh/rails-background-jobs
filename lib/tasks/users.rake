namespace :users do
  desc "Update all users with Clearbit API enrichment"
  task update_all: :environment do
    users = User.all
    puts "Updating #{users.count} users"
    users.each do |user|
      UpdateUserJob.perform_later(user.id)
    end
    puts 'Done'
  end
end
