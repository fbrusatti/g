module PaperTrail
  class Version < ActiveRecord::Base
    attr_accessible :primary_information
  end
end
