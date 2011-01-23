class ClubExperience < Experience
  belongs_to :club
  
  def club_line
    club.name + ", " + location
  end
end