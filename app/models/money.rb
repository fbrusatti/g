class Money < ActiveRecord::Base
  attr_accessible :name, :quotation, :symbol, :id

  def complete_name
    "#{symbol} #{name}"
  end
end
