namespace :db do
  desc "Set up default owner"
  task :set_up_owner => [:environment] do
    user = User.create(name:"gutierrez",
                       surname:"gutierrez",
                       email:" gutierrezinmobiliaria@fibertel.com.ar",
                       password: "123123123")
    Property.paper_trail_off
    Property.all.each do |p|
      p.user = user
      version = p.versions.last
      version.whodunnit = user.surname_with_name
      version.save
      if p.save
        puts "set property user nmr:#{p.id}"
      else
        p.errors.inspect
      end
    end
    Customer.paper_trail_off
    Customer.all.each do |c|
      c.user = user
      version = c.versions.last
      version.whodunnit = user.surname_with_name
      version.save
      if c.save
        puts "set customer user nmr:#{c.id}"
      else
        c.errors.inspect
      end
    end
  end
end
