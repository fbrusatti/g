namespace :db do
  task :migrate_to_new_prices => :environment do
    Property.all.each do |p|
      p.to_rent = p.prices["to_rent"].slice 0, 8 if p.prices["to_rent"]
      p.to_sale = p.prices["to_sale"].slice 0, 8 if p.prices["to_sale"]
      if p.save
        puts "#{p.id} was change"
      else
        puts "error in #{p.id}, #{p.errors.inspect}"
      end
    end
  end
end
