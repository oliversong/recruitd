require 'factory_girl'
require File.expand_path("test/factories/factories.rb")

namespace :db do
  namespace :data do 
  
    desc "Load sample data"
    task :load => :environment do |t|
      #Rake::Task["install"].invoke
      create_students
      create_many_students
      create_companies
      create_clubs
      create_schools_departments_courses
      create_categories
      create_awards
      create_careers
      create_interests
      create_jobs
      create_recruiters
      create_updates
      create_company_files_and_feeds
      create_student_files_and_feeds
      create_company_terms
      create_student_labels
      create_company_labels
      create_followings
      
      puts "Completed loading recruitd sample data."
    end
    
    desc "Load newly created sample data"
    task :load_new => :environment do |t|

      create_newsfeed_items
      
      puts "Completed adding new sample data"
    end
    
    desc "Load 1000 users"
    task :load_many_students => :environment do |t|
      create_many_students
      
      puts "Completed adding new sample data"
    end
    
    desc "Reload sample data"
    task :reload => :environment do |t|
      system("rake db:drop")
      system("rake db:create")
      system("rake db:migrate")
      system("rake db:data:load")
      puts "Data reloaded."
    end
    
  end
end

def create_companies
  20.times do
    c = Factory(:company)
    c.user.entity = c
    c.user.save
  end
  
  puts "Created factory companies"
end

def create_students
  alice = Factory(:student,
                  :gpa => 4.0, 
                  :hometown => "Bellevue, WA",
                  :subtitle => "MIT student who loves to study.",
                  :phone => 6172532226,
                  :user => Factory(:user, :first_name => "Alice", :last_name => "Carroll", :gender_is_male => false)
                  )
  alice.user.entity = alice
  alice.user.save

  bob = Factory(:student, 
                :gpa => 3.6, 
                :hometown => "Houston, TX",
                :subtitle => "UNIX hacker and nightowl",
                :phone => 6172532223,
                :user => Factory(:user, :first_name => "Bob", :last_name => "Smith", :gender_is_male => true)
                )
  bob.user.entity = bob
  bob.user.save
  
  puts "Created factory students"
end

def create_many_students
  20.times{ |i|
    student = Factory(:student)
    student.user.entity = student
    student.user.save
    puts "added student #{i} named #{student.name}" 
  }
  
  puts "Created 20 factory students"
end
                                
def create_work_experiences
  10.times {
    Factory(:work_experience)    
  }
  puts "Created factory work experiences"
end

def create_clubs
  10.times {
    Factory(:club)    
  }
  Student.all.each do |student|
    clubs = Club.all.sort_by{rand}[1..2]
    clubs.each do |club|
      Factory(:club_experience, :student_id => student.id, :club_id => club.id)
    end
  end
  puts "Created factory clubs and put students in clubs"
end

def create_schools_departments_courses
  2.times{
    school = Factory(:school)
    3.times { 
      department = Factory(:department, :school => school)
    }
  }  
  
  puts "adding courses"
  
  data_fetch('courses').each_with_index do |line, index|
    line = line.split("\t")
    course = Factory(:course, :abbrev => line[0], :name => line[1], :department => Department.all.sort_by{rand}.first)
    puts "#{index}: #{course.abbrev}"
    if(index > 100) #for now
      break
    end
  end
  
  Student.all.each do |student|
    department = Department.all.sort_by{rand}.first
    Factory(:school_student, :student => student, :department => department, :school => department.school)
    
    department.courses.sort_by{rand}[1..3].each do |course|
      Factory(:course_student, :student => student, :course => course)
    end
  end
  puts "Created factory schools, departments, and courses"
end

def create_categories
  data_fetch("categories").each do |category_input|
    #school_arr = school.split("\t")
    Factory(:category, :name => category_input.strip)
  end  
  puts "Created categories"
end

def create_awards
  Student.all.each do |student|
    2.times do
      award = Factory(:award)
      Factory(:student_award, :student => student, :term => award, :type => "StudentAward")
    end
  end
  puts "Created awards"
end

def create_careers
  data_fetch("careers").each do |input|
    #school_arr = school.split("\t")
    Factory(:career, :name => input.strip)
  end  
  
  Student.all.each do |student|
    Career.all.sort_by{rand}[1..2].each do |career|
      Factory(:career_student, :student => student, :career => career)
    end
  end
  
  puts "Created careers"
end

def create_interests
  data_fetch("interests").each do |input|
    #school_arr = school.split("\t")
    Factory(:interest, :name => input.strip)
  end
  
  Student.all.each do |student|
    Term::Interest.all.sort_by{rand}[0..2].each do |interest|
      Factory(:student_term, :student => student, :term => interest, :type => "StudentInterest")
    end
  end
  
  puts "Created interests"
end


def create_jobs
  Company.all.each do |company|
    2.times do
      job = Factory(:job, :company => company)
      Career.all.sort_by{rand}[0..1].each do |career|
        Factory(:career_job, :career => career, :job => job)
      end
    end
  end
  puts "Created jobs"
end

def create_recruiters
  Company.all.each do |company|
    2.times do
      r = Factory(:recruiter, :company => company)
      r.user.entity = r
      r.user.save
    end
  end
  puts "Created recruiters"
end

def create_company_files_and_feeds
  Company.all.each do |company|
    Student.all.each do |student|
      Factory(:company_file, :student => student, :company => company)
      Factory(:company_feed, :student => student, :company => company)
    end
  end
  puts "Create company files and feeds"
end

def create_student_files_and_feeds
  Student.all.each do |student|
    Company.all.each do |company|
      Factory(:student_file_company, :student => student, :company => company)
      Factory(:student_feed, :student => student, :company => company)
    end
    Job.all.each do |job|
      Factory(:student_file_job, :student => student, :job => job)
      Factory(:student_feed, :student => student, :job => job)
    end
  end
  puts "Created student files/feeds"
end

def create_company_terms
  Company.all.each do |company|
    Term.all.sort_by{rand}[0..10].each do |term|
      Factory(:company_term, :company => company, :term => term)
    end
  end
  puts "Created company weights on terms"
end

def create_student_labels
  Student.all.each do |student|
    3.times do
      label = Factory(:label, :owner_id => student.id, :owner_type => "Student")
      
      Company.all.sort_by{rand}[1..2].each do |company|
        Factory(:student_labeling, :student => student, :label => label, :company => company)
      end
      
      Job.all.sort_by{rand}[1..3].each do |job|
        Factory(:student_labeling, :student => student, :label => label, :job => job)
      end
    end
  end
  puts "Created students' labels"
end

def create_company_labels
  Company.all.each do |company|
    3.times do
      label = Factory(:label, :owner_id => company.id, :owner_type => "Company")
      
      Student.all.sort_by{rand}[0..3].each do |student|
        Factory(:company_labeling, :student => student, :label => label, :company => company)
      end
    end
  end
  puts "Created companies' labels"
end

def create_followings
  Student.all.each do |student|
    Company.all.sort_by{rand}[0..2].each do |company|
      Factory(:following, :follower => student.user, :followed => company.user)
    end
  end
  
  Company.all.each do |company|
    Student.all.sort_by{rand}[0..2].each do |student|
      Factory(:following, :follower => company.user, :followed => student.user)
    end
  end
end

def create_updates
  Student.all.each do |student|
    3.times do
      Factory(:update, :user => student.user)
    end
  end
  
  Company.all.each do |company|
    3.times do
      Factory(:update, :user => company.user)
    end
  end
  puts "Created updates"
end

def create_newsfeed_items
  Update.all.each do |update|
    update.user.followers.each do |follower|
      Factory(:newsfeed_item_update, :reference => update, :user => follower, :text => update.text, :update_time => update.updated_at, :entity => update.user.entity)
    end
  end
  
  puts "Created newsfeed items"
end