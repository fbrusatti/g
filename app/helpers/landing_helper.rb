module LandingHelper
  CHANGES = %w{create update}
  def changes
    CHANGES.map{ |c| [t(".#{c}"), c] }
  end
end
