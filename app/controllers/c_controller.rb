class CController < ApplicationController
  
  def highlight
    if !current_user.is_company_entity?
      render :nothing => true and return
    end
    
    company_id = current_user.entity.company_id
    
    ch = CompanyHighlighting.new(:student_id => params[:student_id], 
                            :company_id => company_id,
                            :reference_type => params[:reference_type],
                            :reference_id => params[:reference_id])
    puts ch
    puts ch.save
    puts ch
    render :nothing => true and return
  end
  
  def unhighlight
    if !current_user.is_company_entity?
      render :nothing => true and return
    end
    
    company_id = current_user.entity.company_id
    
    chs = CompanyHighlighting.find(:all, :conditions => ["student_id = ? AND company_id = ? AND reference_type = ? AND reference_id = ?", params[:student_id], company_id, params[:reference_type], params[:reference_id] ])
    chs.each do |ch|
      ch.destroy
    end
    render :nothing => true and return
  end
  
end
