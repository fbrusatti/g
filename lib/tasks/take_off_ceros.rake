namespace :db do
  task :take_off_ceros => :environment do
    Property.all.each do |p|
      if p.type_transaction  == "Venta "
        if p.to_sale.present?
          p.to_rent = nil
          puts "take off ceros in #{p.id}"
        end
      elsif p.type_transaction == " Alquiler"
        if p.to_rent.present?
          p.to_sale = nil
          puts "take off ceros in #{p.id}"
        end
      end
      p.save
    end
  end
end
