require 'csv'
namespace :db do
  task :import_photos, [:status_p] => [:environment] do |t, args|
    status_p = args.status_p == "a" ? "Archivada" : "Disponible"
    ## example
    # file_f = "/home/edu/Desktop/resultsetFotos.csv"
    Property.all.each do |p|
      if p.status == status_p
        CSV.foreach(file_f, :headers => true) do |rowf|
          begin
            # rowf[13] delete 1==true
            if rowf[1] == p.old_reference && rowf[13] != "1"
              photo = p.photos.build
              photo.image = File.open("/home/edu/Desktop/Gutierrez/#{rowf[1].strip}_#{rowf[2]}.jpg")
              if p.save
                puts "----#{p.id} -> #{rowf[1].strip}_#{rowf[2]}.jpg "
              else
                puts p.errors.inspect
              end
            end
          rescue
            msj=""
            msj << "**** the picture #{rowf[1].strip}_#{rowf[2]}.jpg to property #{p.id}"
            msj << " is not marked to delete and not found it in file system "
            puts msj
          end
        end # CSV
      end #if
    end
  end # task
end
