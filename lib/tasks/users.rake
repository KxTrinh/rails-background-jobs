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

  desc "Enrich a given user with Clearbit (sync)"
  task :update, [:user_id] => :environment do |t, args|
    user = User.find(args[:user_id])
    puts "Enriching #{user.email}..."
    UpdateUserJob.perform_later(user.id)
    # rake task will return when job is _done_
    puts 'Done'
  end

end
