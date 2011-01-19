###### SEQUENCES ######

FACTORY_DATA_DIRECTORY = File.join(::Rails.root.to_s, "test", "factories", "data")

LIPSUM_FULL = File.open(File.join(FACTORY_DATA_DIRECTORY, "lipsum.txt")).read

Factory.sequence :simple do |n|
  n
end

Factory.sequence :lipsum_word do |n|
  @lipsum = @lipsum ? @lipsum : File.open(File.join(FACTORY_DATA_DIRECTORY, "lipsum.txt")).read.split
  @lipsum[n % @lipsum.count]
end

Factory.sequence :female_description do |n|
  @female_descriptions = @female_descriptions ? @female_descriptions : File.open(File.join(FACTORY_DATA_DIRECTORY,"female_descriptions.txt")).readlines
  @female_descriptions[n % @female_descriptions.count].strip
end

def data_fetch(name)
  File.open(File.join(FACTORY_DATA_DIRECTORY, "#{name}.txt")).readlines
end

def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def rand_price(from, to)
  rand_in_range(from, to).round(2)
end

def rand_time(from, to)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

def single_unique_fetch(name, n)
  if(!@data_store)
    @data_store = {}
  end
  
  if(!@data_store[name])
    puts "\nloading #{name} into data_store!\n"
    @data_store[name] = data_fetch(name)
  end
  #names = data_fetch(name)
  
  # if n / names.count > 0
  #   return_str = "#{names[n%names.length].strip}#{loops}"
  # else
    return_str = @data_store[name][n % @data_store[name].length].strip
  # end
  return_str
end

Factory.sequence :company_name do |n|
  single_unique_fetch('companies',n)
end

Factory.sequence :male_first_name do |n|
  single_unique_fetch('male_names',n)
end

Factory.sequence :female_first_name do |n|
  single_unique_fetch('female_names',n)
end

Factory.sequence :last_name do |n|
  single_unique_fetch('last_names',n).capitalize
end

Factory.sequence :interest do |n|
  single_unique_fetch('interests',n)
end

Factory.sequence :career do |n|
  single_unique_fetch('careers',n)
end

Factory.sequence :city do |n|
  single_unique_fetch('cities',n)
end

Factory.sequence :phone do |n|
  rand(9999999999)
end


###### DEFINITIONS ######


Factory.define :user do |p|
  p.gender_is_male do
    (rand(2) == 1)
  end
  p.first_name do |me|
    if me.gender_is_male
      name = Factory.next(:male_first_name)
    else
      name = Factory.next(:female_first_name)
    end
    name
  end
  p.last_name do
    Factory.next(:last_name)
  end
  p.email { |u| "#{u.first_name}#{Factory.next(:simple)}@example.com".downcase }
  #p.email {|u| "#{Factory.next(:simple)}@example.com"}
  p.password 'foobar'
  p.password_confirmation 'foobar'
  
  # if p.gender_is_male
  # filename = File.join(DATA_DIRECTORY, "#{gender}_names.txt")
  # names = File.open(filename).readlines
  # password = "foobar"
  # photos = Dir.glob("lib/tasks/sample_data/#{gender}_photos/*.jpg").shuffle
  # last_names = @lipsum.split
  # names.each_with_index do |name, i|
  # name.strip!
  # #full_name = "#{name} #{last_names.pick.capitalize}"
  # user = User.create!(:email => "#{name.downcase}@example.com",
  #                         :password => password, 
  #                         :password_confirmation => password,
  #                         :first_name => name,
  #                         :middle_name => "D",
  #                         :last_name => last_names.pick.capitalize,
  #                         :description => @lipsum)
  # user.last_logged_in_at = Time.now
  # user.save
  # gallery = Gallery.unsafe_create(:user => user, :title => 'Primary',
  #                                 :description => 'My first gallery')
  # 
  # Photo.unsafe_create!(:uploaded_data => photo, :user => user,
  #                      :primary => true, :avatar => true,
  #                      :gallery => gallery)
  # 
end

Factory.define :photo do |f|
  f.association :gallery
  f.association :user
  f.primary true
  f.avatar true
  f.uploaded_data do 
    photos = Dir.glob("lib/tasks/sample_data/#{gender}_photos/*.jpg").shuffle
    uploaded_file(photos[i], 'image/jpg')
  end
end

# # This will use the User class (Admin would have been guessed)
# Factory.define :admin, :class => user do |p|
#   p.first_name 'Admin'
#   p.last_name  'User'
#   p.admin true
# end

Factory.define :company do |f|
  f.name { Factory.next(:company_name) }
  f.user { |u| Factory.create(:user, :first_name => "", :last_name => u.name) }
  
end

# Factory.define :address do |f|
#   f.line1 { "#{rand(1000)} Main St" }
#   f.line2 ""
#   f.city "Boston"
#   f.state "MA"
#   f.zip do
#     begin 
#       n = rand(99999) 
#     end while n < 10000
#     n
#   end
# end

Factory.define :term do |f|
  f.name "#{Factory.next(:lipsum_word)} #{Factory.next(:lipsum_word)}"
end

Factory.define :student do |f|
  # def f.default_schools
  #   if !@default_schools
  #     @default_schools = []
  #     data_fetch("schools").each do |school|
  #       school_arr = school.split("\t")
  #       @default_schools << Factory.build(:school, :name => school_arr[0].strip, :address_city => school_arr[1].strip, :address_state => school_arr[2].strip)
  #     end
  #   end
  #   @default_schools
  # end
  # 
  # #pick a random number of schools between 0 and 2.
  # f.schools do    
  #   f.default_schools.sort_by{rand}.slice(0...rand(3))
  # end
  
  f.user do |s|
    Factory(:user, :entity_type => "Student") #TODO: fix entity_id => s.id
  end
  #f.hometown "Boston, MA"
  f.gpa { rand(500)/100.0 }
  f.terms { |terms| [terms.association(:term)]}
  f.phone { rand(9999999999) }
  #f.student_terms { |student_terms| [student_terms.association(:student_term)]}
  
  f.hometown do
     Factory.next(:city)
   end
  f.subtitle do
    "#{Factory.next(:lipsum_word)} #{Factory.next(:lipsum_word)} #{Factory.next(:lipsum_word)}"
  end  
  f.address_line1 { "#{rand(1000)} Main St" }
  f.address_line2 ""
  f.address_city "Boston"
  f.address_state "MA"
  f.address_zip do
    begin 
      n = rand(99999) 
    end while n < 10000
    n
  end
  
end

Factory.define :club do |f|
  f.name { "#{Factory.next(:lipsum_word).capitalize} Student Group"}
  f.description "Just another student group"
  f.term do |s| 
    Factory.create(:term, :name => s.name)
  end
end

Factory.define :club_experience, :class => :club_experience do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.club { Club.all.count > 0 ? Club.all.sort_by{rand}.first : Factory.create(:club) }
  f.startdate { 2.years.ago }
  f.enddate { 2.years.ago + 3.months }
  f.job_title "President"
  f.description "Head of awesome student group"
  f.location "Cambridge, MA"
end


Factory.define :work_experience, :class => :work_experience do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.startdate { 2.years.ago }
  f.enddate { 2.years.ago + 3.months }
  f.job_title "Intern"
  f.description "Intern at this excellent company"
  f.location "New York, NY"
  f.company { 
    Company.all.count > 0 ? Company.all.sort_by{rand}.first : Factory.create(:company, :name => "ABC Incorporated")   
  }
end

Factory.define :department do |f|
  f.name "Department of #{Factory.next(:lipsum_word).capitalize}"
  f.school_id 1
  f.term do |s| 
    Factory.create(:term, :name => s.name)
  end
end

Factory.define :school do |f|
  f.name "#{Factory.next(:lipsum_word).capitalize} University"
  f.term do |s| 
    Factory.create(:term, :name => s.name)
  end
  f.address_line1 { "#{rand(1000)} Main St" }
  f.address_line2 ""
  f.address_city "Boston"
  f.address_state "MA"
  f.address_zip do
    begin 
      n = rand(99999) 
    end while n < 10000
    n
  end
end

Factory.define :school_student do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.school { School.all.count > 0 ? School.all.sort_by{rand}.first : Factory.create(:school) }
  f.department { Department.all.count > 0 ? Department.all.sort_by{rand}.first : Factory.create(:department) }
  f.gpa 3.50
  f.degree_name "Bachelor of Science"
end

Factory.define :course do |f|
  f.name { "#{Factory.next(:lipsum_word)} #{Factory.next(:lipsum_word)}" }
  f.abbrev { "#{rand(24)+1}.#{rand(999)}" }
  f.department_id 1
  f.term do |s| 
    Factory.create(:term, :name => s.name)
  end
end

Factory.define :period do |f|
  f.season "Fall"
  f.year 2010
  f.school_id 1
end

Factory.define :course_student do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.course { Course.all.count > 0 ? Course.all.sort_by{rand}.first : Factory.create(:course) }
  f.period_id 1
  f.comments "I really liked this course!"
end

Factory.define :category do |f|
  f.name {"#{Factory.next(:lipsum_word)} category"}
end

Factory.define :award do |f|
  f.name {"National award for excellence in #{Factory.next(:lipsum_word)}"}
  f.category { Category.all.count > 0 ? Category.all.sort_by{rand}.first : Factory.create(:category) }
  f.url "http://www.google.com"
end

Factory.define :career do |f|
  f.name {Factory.next(:career)}
  f.term do |s|
    Factory.create(:term, :name => s.name)
  end
end

Factory.define :career_student do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.career { Career.all.count > 0 ? Career.all.sort_by{rand}.first : Factory.create(:career) }
end

Factory.define :interest do |f|
  f.name {Factory.next(:interest)}
end

Factory.define :student_term do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.term { Term.all.count > 0 ? Term.all.sort_by{rand}.first : Factory.create(:term) }
end

Factory.define :student_award, :class => :student_term do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.term { Award.all.count > 0 ? Award.all.sort_by{rand}.first : Factory.create(:award) }
  f.term_type "Award"
end

Factory.define :job do |f|
  f.title "Analyst, Equity Research"
  f.description LIPSUM_FULL
  f.company { Company.all.count > 0 ? Company.all.sort_by{rand}.first : Factory.create(:company) }
  f.basic_qualifications "We are looking for a stellar candidate with relevant Wall Street experience (e.g., an investment banking financial analyst or equity research associate).  The candidate should have a passion for stocks.  The candidate must be an excellent writer and possess modeling and valuation skills. Intellectual curiosity, a strong work ethic and a team player mentality are desired attributes."
  #f.target_start "We would like the candidate to start as soon as possible."
end

Factory.define :career_job do |f|
  f.career { Career.all.count > 0 ? Career.all.sort_by{rand}.first : Factory.create(:career) }
  f.job { Job.all.count > 0 ? Job.all.sort_by{rand}.first : Factory.create(:job) }
end

Factory.define :recruiter do |f|
  f.phone { rand(9999999999) }
  f.company { Company.all.count > 0 ? Company.all.sort_by{rand}.first : Factory.create(:company) }
  f.user { Factory.create(:user) }
end

Factory.define :company_file do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.company { Company.all.count > 0 ? Company.all.sort_by{rand}.first : Factory.create(:company) }
  f.notes LIPSUM_FULL
  f.rating { rand(5) + 1 }
end

Factory.define :company_feed do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.company { Company.all.count > 0 ? Company.all.sort_by{rand}.first : Factory.create(:company) }
  f.last_seen { rand_time(2.months.ago, Time.now ) }
  f.score { rand(100) + 1 }
end

Factory.define :student_file do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.notes LIPSUM_FULL
  f.rating { rand(5) + 1 }
  f.starred { (rand > 0.5) }
end

Factory.define :student_feed do |f|
  f.student { Student.all.count > 0 ? Student.all.sort_by{rand}.first : Factory.create(:student) }
  f.last_seen { rand_time(2.months.ago, Time.now ) }
  f.score { rand(100) + 1 }
end

Factory.define :company_term do |f|
  f.company { Company.all.count > 0 ? Company.all.sort_by{rand}.first : Factory.create(:company) }
  f.term { Term.all.count > 0 ? Term.all.sort_by{rand}.first : Factory.create(:term) }
  f.weight { rand(100) + 1 }
  f.last_updated_by_user_id do |s|
    if (s.company.recruiters.count > 0)
      i = s.company.recruiters.first.user_id
    else 
      r = Factory.create(:recruiter, :company => s.company)
      i = r.user_id
    end
    i
  end
end

Factory.define :label do |f|
  f.name {"#{Factory.next(:lipsum_word)}"}
end

Factory.define :student_labeling do |f|
  f.label { Label.all.count > 0 ? Label.all.sort_by{rand}.first : Factory.create(:label) }
  f.student do |s|
    s.label.owner
  end
end

Factory.define :company_labeling do |f|
  f.label { Label.all.count > 0 ? Label.all.sort_by{rand}.first : Factory.create(:label) }
  f.company do |s|
    s.label.owner
  end
end

Factory.define :update do |f|
  f.user { User.all.count > 0 ? User.all.sort_by{rand}.first : Factory.create(:user) }
  f.text LIPSUM_FULL
end


Factory.define :following do |f|
end

Factory.define :newsfeed_item_update, :class => "NewsfeedItem" do |f|
  f.update_time { rand_time(2.weeks.ago, Time.now ) }
end