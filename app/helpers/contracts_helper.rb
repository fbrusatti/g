module ContractsHelper

  def fill_with_renter
    unless @contract.renter.nil?
      [@contract.renter].map(&:attributes).to_json
    end
  end

  def fill_with_property
    unless @contract.property.nil?
      [@contract.property].map(&:attributes).to_json
    end
  end
end
