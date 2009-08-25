class Species < ActiveRecord::Base

  def to_s
    "#{common} (#{scientific})"
  end
end
