class VotesController < ApplicationController
  # access_control do
  #   allow :admin
  #   #allow logged_in, :to => [:vote]
  # end
  
  before_filter :check_if_admin, :except => [:vote]
  
  def vote
    if !current_user
      render :nothing => true and return
    end
    
    vote = Vote.find(:first, :conditions => ["voter_id = ? and voteable_type = ? and voteable_id = ?", current_user.id, params[:voteable_type], params[:voteable_id]])
    if vote != nil
      if vote.vote != (params[:vote] == "for") #new vote is reversing the previous one's
        @voteable = vote.voteable
        vote.destroy
        render "shared/vote"
      else 
        # vote in same orientation already exists; no voting twice!
        # so, do nothing.
        render :nothing => true
      end
    else
      # vote = Vote.new(:voteable_id => params[:voteable_id], :voteable_type => params[:voteable_type], :voter_id => current_user.id, :voter_type => "User", :vote => )
      # vote.save
      @voteable = Kernel.const_get(params[:voteable_type]).find(params[:voteable_id])
      if (params[:vote] == "for")
        current_user.vote_for(@voteable)
      else
        current_user.vote_against(@voteable)
      end
      render "shared/vote"
    end
  end

 
  def index
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.xml
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.xml
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vote }
    end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.xml
  def create
    if Vote.find(:first, :conditions => ["user_id = ? and playlist_id = ?", current_user.id, @playlist.id]) != nil
      respond_to do |format|
        format.html { redirect_to(@playlist, :notice => 'You have already voted on this playlist.') }
      end
    else
      @vote = Vote.new(:playlist_id => @playlist.id, :user_id => current_user.id)
      respond_to do |format|
        if @vote.save
          format.html { redirect_to([@playlist, @vote], :notice => 'Vote was successfully created.') }
          format.xml  { render :xml => @vote, :status => :created, :location => @vote }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /votes/1
  # PUT /votes/1.xml
  def update
    @vote = Vote.find(params[:id])
   
    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to([@playlist,@vote], :notice => 'Vote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.xml
  def destroy
     @vote = Vote.find(params[:id])
     @vote.destroy

    respond_to do |format|
      format.html { redirect_to playlist_votes_path(@playlist) }
      format.xml  { head :ok }
    end
  end

  def load_playlist
    @playlist = Playlist.find_by_permalink(params[:playlist_id])
  end
  
  private
    def check_if_admin
      if !current_user_is_admin
        render :nothing => true and return
      end
    end
end