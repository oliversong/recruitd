puts xmlp["first_name"]
puts xmlp["last_name"]
puts xmlp["industry"]
puts xmlp["headline"]
puts xmlp["location"]["name"]
puts xmlp["summary"]
puts xmlp["honors"]
puts xmlp["interests"]

if(xmlp["positions"] && Integer(xmlp["positions"]["total"]) >= 1)
  if Integer(xmlp["positions"]["total"]) == 1
    positions = [ xmlp["positions"]["position"] ]  
  else
    positions = xmlp["positions"]["position"]
  end
  
  positions.each do |position|
    puts position["title"]
    puts position["start_date"]["year"]
    puts position["is_current"]
    puts position["company"]["name"]
    puts position["company"]["type"]
    puts position["company"]["industry"]
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