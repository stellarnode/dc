namespace :poll do

  desc "Open polls"
  task :open => :environment do
  	Poll.created.each do |poll|
  		if DateTime.now >= poll.start && DateTime.now <= poll.finish
  			poll.open
        poll.save!
  		end
  	end
  end

  desc "Close polls"
  task :close => :environment do
  	Poll.opened.each do |poll|
  		if DateTime.now > poll.finish
  			poll.close
        poll.save!
  		end
  	end
  end

# You can add any rake task inside :all task
  desc "Do all poll tasks"
  task :all => :environment do
  	Rake::Task['poll:open'].execute
  	Rake::Task['poll:close'].execute
  end
end
