require 'csv'
namespace :db do
  desc "Import Customers from csv file"
  task :import_customers => [:environment] do
    # configure
    # file = "/home/edu/Desktop/resultset.csv"
    i=0
    CSV.foreach(file, :headers => true) do |row|
      c = Customer.new
      c.name = names(row[1], row[2])
      c.surname = names(row[3], "")
      c.phones[:phone] = phoness(row[4], row[5])
      c.phones[:mobile_phone] = phoness(row[6], row[7])
      c.address = row[9]
      c.email = row[8]
      c.dob = row[69]
      c.dni = row[24]
      c.description = row[18]
      if c.save
        puts "crated Customer number #{i}"
      else
        puts c.errors.inspect
      end
      i+=1
    end
  end
  def names(n1, n2)
    "#{n1} #{n2}".strip.blank? ? "Cliente" : "#{n1} #{n2}"
  end
  def phoness(n1, n2)
    "#{n1} #{n2}" .strip.blank? ? "999" : "#{n1} #{n2}"
  end
end
