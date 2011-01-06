class RepTransactionsController < ApplicationController
  # GET /rep_transactions
  # GET /rep_transactions.xml
  def index
    @rep_transactions = RepTransaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rep_transactions }
    end
  end

  # GET /rep_transactions/1
  # GET /rep_transactions/1.xml
  def show
    @rep_transaction = RepTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rep_transaction }
    end
  end

  # GET /rep_transactions/new
  # GET /rep_transactions/new.xml
  def new
    @rep_transaction = RepTransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rep_transaction }
    end
  end

  # GET /rep_transactions/1/edit
  def edit
    @rep_transaction = RepTransaction.find(params[:id])
  end

  # POST /rep_transactions
  # POST /rep_transactions.xml
  def create
    @rep_transaction = RepTransaction.new(params[:rep_transaction])

    respond_to do |format|
      if @rep_transaction.save
        format.html { redirect_to(@rep_transaction, :notice => 'RepTransaction was successfully created.') }
        format.xml  { render :xml => @rep_transaction, :status => :created, :location => @rep_transaction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rep_transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rep_transactions/1
  # PUT /rep_transactions/1.xml
  def update
    @rep_transaction = RepTransaction.find(params[:id])

    respond_to do |format|
      if @rep_transaction.update_attributes(params[:rep_transaction])
        format.html { redirect_to(@rep_transaction, :notice => 'RepTransaction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rep_transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rep_transactions/1
  # DELETE /rep_transactions/1.xml
  def destroy
    @rep_transaction = RepTransaction.find(params[:id])
    @rep_transaction.destroy

    respond_to do |format|
      format.html { redirect_to(rep_transactions_url) }
      format.xml  { head :ok }
    end
  end
end
