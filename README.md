G
=

## Migrate


#### clean up your db

``` delete from properties;```

```  delete from customers; ```

``` delete from money;```

``` delete from versions;```

``` ALTER SEQUENCE photos_id_seq RESTART WITH 1;```

``` ALTER SEQUENCE appointments_id_seq RESTART WITH 1;```

``` ALTER SEQUENCE customers_id_seq RESTART WITH 1;```

``` ALTER SEQUENCE money_id_seq RESTART WITH 1;```

``` ALTER SEQUENCE properties_id_seq RESTART WITH 1;```

####configure your paths

#
    ## lib/taks/data_to_db_properties.rake
    file_p = "your_path/resultsetPopriedades.csv"
    file_c = "your_path/resultsetClaves.csv"
    file_a = "your_path/resultsetAreas.csv"

    ## lib/taks/data_to_db_customers.rake
    file = "your_path/resultset.csv"

    ## lib/taks/data_to_db_photos.rake
    # file_f = "your_pathresultsetFotos.csv"
    # photo.image = File.open("your_path_where_are_photos/#{rowf[1].strip}_#{rowf[2]}.jpg")

####run migration

* rake db:import_properties["a"]
* rake db:import_properties["d"]
* rake db:import_photos["d"] ~40min
* rake db:import_photos["a"] ~120min
* rake db:import_customers
* rake db:set_up_owner
