# encoding: utf-8
require 'csv'
namespace :db do
  desc "Import Properties from csv file"
  task :import_properties, [:status_p] => [:environment] do |t, args|
    status_p = args.status_p == "a" ? "Archivada" : "Disponible"
    ## configure
    # file_p = "/home/edu/Desktop/resultsetPopriedades.csv"
    # file_c = "/home/edu/Desktop/resultsetClaves.csv"
    # file_a = "/home/edu/Desktop/resultsetAreas.csv"

    CSV.foreach(file_p, :headers => true) do |row|
      status_f = (row[58] == "1" ? "Archivada" : "Disponible")
      if status_p == status_f
        p = Property.new
        p.owner = create_owner(row) || nil
        p.old_reference = row[0]
        p.status = status_f

        # fundamental fileds
        p.address = row[4].present? ? row[4].strip : "Direccion por defecto"
        p.type_transaction = transaction_type(row[80], row[81])
        p.prices["to_rent"] = get_price(row[82], row[81])
        if p.prices["to_rent"].present?
          p.build_money_to_rent(name: "#{row[41] == '1224' ? 'ARG' : 'Dolar'}")
        end
        p.prices["to_sale"] = get_price(row[40], row[80])
        if p.prices["to_sale"].present?
          p.build_money_to_sale(name: "#{row[41] == '1224' ? 'ARG' : 'Dolar'}")
        end

        # commun fields
        p.amount_rooms = row[14].to_i
        p.amount_bathrooms = row[15].to_i
        p.description = row[52]
        p.lot = row[19].to_i
        p.meters_constructed = row[20].to_i
        p.description_to_print = row[104] == row[105] ? row[104] : "#{row[104]} #{row[105]}"
        p.key_possessor = possessor_key(row[47])
        p.type_property = type_property(row[9], file_c)
        p.influence_zone = influence_zone(row[7], file_a)
        if p.save
          puts  ' \ ' + "created Property number #{p.id}"
        else
          puts p.errors.inspect
        end
      end
      # p.title_to_print = row[]
      # p.position = row[] TU
    end # CSV
  end # task

  def influence_zone(izfkey, file_a)
    izname = ""
    CSV.foreach(file_a, :headers => true) do |rowa|
      if rowa[0] == izfkey
        izname = rowa[1].strip.upcase
        break
      end
    end
    izname
  end

  def type_property(tprop_fk, file_c)
    tp_name = ""
    CSV.foreach(file_c, :headers => true) do |rowc|
      if rowc[1] == tprop_fk
        tp_name = rowc[3].strip
        break
      end
    end
    case tp_name
    when "Apartamento", "Apartamento Dúplex", "Loft"
      tp_name = "Dpto"
    when "Casa", "Cabaña"
      tp_name = "Casa"
    when "Terreno", "Fracción", "Parcela"
      tp_name = "Terreno"
    when "Quinta"
      tp_name = "Quinta"
    when "Local Comercial", "Comercio", "Nave industrial"
      tp_name = "Local"
    when "Oficina", "Estudio"
      tp_name = "Oficina"
    when "Campo"
      tp_name = "Campo"
    else
      tp_name = ""
    end
    tp_name
  end # type_property

  def possessor_key(possesor)
    if possesor == "a"
      kp = "Dueño"
    elsif possesor == "b"
      kp = "Oficina"
    elsif possesor == "c"
      kp = "Vendedor"
    else
      kp = ""
    end
    [kp]
  end

  def transaction_type(sale, rent)
    sale, rent = (sale == "1" ? "Venta" : ""), (rent == "1" ? "Alquiler" : "")
    "#{sale} #{rent}".present? ? "#{sale} #{rent}" : "Defecto"
  end

  def get_price(price, transacction)
    price.present? ? price : "111111" if transacction == "1"
  end

  def create_owner(row)
    if "#{row[67]} #{row[68]}".strip.present?
      c = Customer.new
      c.name =  row[67].blank? ? "Cliente" : row[67]
      c.surname =  row[68].blank? ? "Cliente" : row[68]
      c.dni = row[113]
      phoness(c,row)
      c.address =  row[6]
      c.email =  row[73]
      c.profession = row[66]
      c.description = row[74]
      # c.dob
      if c.save
        puts "_ created Customer number #{c.id}"
      else
        puts c.errors.inspect
      end
    end
    c
  end

  def phoness(customer, row)
    customer.phones[:phone] =  "#{row[69]} #{row[70]}".strip
    customer.phones[:mobile_phone] =  "#{row[71]} #{row[72]}".strip
    if "#{customer.phones[:phone]} #{customer.phones[:mobile_phone]}".blank?
      customer.phones[:phone] = "999"
    end
  end
end
