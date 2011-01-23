require_dependency 'experience'
require_dependency 'term'
require_dependency 'student_term'
require_dependency 'student_file'

class Student < User
  has_many :experiences
  
  has_many :work_experiences
  has_many :companies, :through => :work_experiences
   
  has_many :club_experiences
  has_many :clubs, :through => :club_experiences

  has_many :school_students
  has_many :schools, :through => :school_students
  
  has_many :course_students
  has_many :courses, :through => :course_students
  
  has_many :career_students
  has_many :careers, :through => :career_students
  
  has_many :student_terms
  has_many :terms, :through => :student_terms
  
  has_many :student_files
  has_many :student_feeds, :order => "score DESC"
  
  has_many :labels, :as => :owner
  has_many :company_labelings
  
  # has_many :student_awards, :class_name => "StudentTerm::StudentAward"
  # has_many :awards, :through => :student_awards
  # 
  # has_many :student_interests
  # has_many :interests, :through => :student_interests
  #
  # 
  # has_many :company_students
  # has_many :companies, :through => :company_students
  # 
  # has_many :job_students, :order => "job_score desc"
  # has_many :jobs, :through => :job_students
  
  def interests
    return terms.find_all_by_type('Interest')
  end
  
  def awards
    return terms.find_all_by_type('Award')
  end
  
  def skills
    return terms.find_all_by_type('Skill')
  end
  
  def showable_student_feeds
    return student_feeds.showable
  end
  
  def before_validation_on_create
      self.phone = phone.gsub(/[^0-9]/, "")
  end
  
  def before_validation_on_update
      self.phone = phone.gsub(/[^0-9]/, "")
  end

  
  def import_linkedin_xml(xml)
    #a = File.open(File.join(Rails.root, "test", "import", "example_linkedin.xml")).read
    
    xmlp = (Hash.from_xml(xml))["person"]
    
    if xmlp["first_name"]
      self.user.first_name = xmlp["first_name"]
    end
    
    if xmlp["last_name"]
      self.user.last_name = xmlp["last_name"]
    end
    
    if xmlp["industry"]
      career = Career.find_or_initialize_by_name(xmlp["industry"])
      cs = CareerStudent.new(:career => career, :student => self)
      cs.save
    end
    
    if xmlp["headline"]
      self.subtitle = xmlp["headline"]
    end
    
    if xmlp["location"] && xmlp["location"]["name"]
      self.hometown = xmlp["location"]["name"]
    end
    
    if xmlp["summary"]
      self.highlights = xmlp["summary"]
    end
    
    puts xmlp["honors"]
    if xmlp["interests"]
      xmlp["interests"].split(%r{[\n,]}).map{|elt| elt.strip}.each do |i|
        if !i.blank?
          interest = Term::Interest.find_or_initialize_by_name(i)
          si = StudentTerm.new(:term => interest, :student => self)
          si.save
        end
      end
    end
    
    if(xmlp["positions"] && Integer(xmlp["positions"]["total"]) >= 1)
      if Integer(xmlp["positions"]["total"]) == 1
        positions = [ xmlp["positions"]["position"] ]
      else
        positions = xmlp["positions"]["position"]
      end
      
      positions.each do |position|
        if !position["company"]
          continue
        end
        
        company = Company.find_by_name(position["company"]["name"])
        if !company
          company = Company.new(:name => position["company"]["name"])
          
          if position["company"]["type"]
            idx = Company::OWNERSHIP_CATEGORIES.index(position["company"]["type"])
            if idx
              company.ownership_category = idx
            end
          end
          
          company.save
          
          if position["company"]["industry"]
            career = Career.find_or_initialize_by_name(position["company"]["industry"])
            cc = CareerCompany.new(:career => career, :company => company)
            cc.save
          end
        end
          
        experience = WorkExperience.new(:student => self, :company => company)
        
        if position["title"]
          experience.job_title = position["title"]
        end
        
        experience.save
        
        #TODO: fix start/end date
        # if position["start_date"] && position["start_date"]["year"]
        # end
        # puts position["is_current"]

      end
    end
    
    if(xmlp["educations"] && Integer(xmlp["educations"]["total"]) >= 1)
      if Integer(xmlp["educations"]["total"]) == 1
        educations = [ xmlp["educations"]["education"] ]
      else
        educations = xmlp["educations"]["education"]
      end
      
      educations.each do |education|
        puts education["school_name"]
        puts education["activities"]
        puts education["degree"]
        puts education["start_date"]["year"]
        puts education["end_date"]["year"]
        puts education["field_of_study"]
      end
    end
    
    if(xmlp["phone_numbers"] && Integer(xmlp["phone_numbers"]["total"]) >= 1)
      if Integer(xmlp["phone_numbers"]["total"]) == 1
        phone_numbers = [ xmlp["phone_numbers"]["phone_number"] ]
      else
        phone_numbers = xmlp["phone_numbers"]["phone_numbers"]
      end
      
      phone_numbers.each do |phone_number|
        puts phone_number["phone_type"]
        puts phone_number["phone_number"]
      end
    end
    
    puts xmlp["main_address"]
    
    self.save
    
  end
  
end
