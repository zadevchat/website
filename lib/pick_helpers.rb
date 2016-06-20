module PickHelpers

  def picks_by_guest( picks )
    picks.group_by { |pick| pick["by"] }
  end

end
