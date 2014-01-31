# encoding: utf-8
namespace :db do
  task :improve_money => :environment do
    @marg = Money.create(name: 'ARG', symbol: '$')
    @meeuu = Money.create(name: 'Dolar', symbol: '$')

    Property.paper_trail_off

    Money.all.each do |m|
      if m.p_rent_id
        p = Property.unscoped.find(m.p_rent_id)
        p.money_to_rent = m.name == 'Dolar' ? @meeuu : @marg
        if p.save
          puts "improve money in Property #{p.id}"
        else
          puts p.errors.inspect
        end
      end
      if m.p_sale_id
        p = Property.unscoped.find(m.p_sale_id)
        p.money_to_sale = m.name == 'Dolar' ? @meeuu : @marg
        puts "improve money in Property #{p.id}" if p.save
      end
    end
    # destroy old moneys
    Money.destroy_all("id <> #{@marg.id} and id <> #{@meeuu.id}")
  end
end
