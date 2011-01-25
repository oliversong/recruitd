class CController < ApplicationController
  
  def highlight
    if !current_user.is_company_entity?
      render :nothing => true and return
    end
    
    company_id = current_user.company_id
    
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
    
    company_id = current_user.company_id
    
    chs = CompanyHighlighting.find(:all, :conditions => ["student_id = ? AND company_id = ? AND reference_type = ? AND reference_id = ?", params[:student_id], company_id, params[:reference_type], params[:reference_id] ])
    chs.each do |ch|
      ch.destroy
    end
    render :nothing => true and return
  end
  
  def follow_term
    if !current_user.is_company_entity?
      render :nothing => true and return
    end
    
    company_id = current_user.company_id
    
    ct = CompanyTerm.find_or_initialize_by_company_id_and_term_id(company_id, params[:term_id])
    ct.weight = 10
    ct.save
    
    @term_id = params[:term_id]
    @followed = true
    render "shared/follow_term"
    
  end
  
  def unfollow_term
    if !current_user.is_company_entity?
      render :nothing => true and return
    end
    
    company_id = current_user.company_id
    
    ct = CompanyTerm.find_by_company_id_and_term_id(company_id, params[:term_id])
    if ct
      ct.destroy
    end
    
    @term_id = params[:term_id]
    @followed = false
    render "shared/follow_term"
    
  end
  
end
