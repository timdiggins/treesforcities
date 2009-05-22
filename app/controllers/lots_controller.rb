class LotsController < ApplicationController
  # GET /lots
  # GET /lots.xml
  def index
    @lots = Lot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lots }
    end
  end

  # GET /lots/1
  # GET /lots/1.xml
  def show
    @lot = Lot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lot }
    end
  end

  # GET /lots/new
  # GET /lots/new.xml
  def new
    @lot = Lot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lot }
    end
  end

  # GET /lots/1/edit
  def edit
    @lot = Lot.find(params[:id])
  end

  # POST /lots
  # POST /lots.xml
  def create
    @lot = Lot.new(params[:lot])

    respond_to do |format|
      if @lot.save
        flash[:notice] = 'Lot was successfully created.'
        format.html { redirect_to(@lot) }
        format.xml  { render :xml => @lot, :status => :created, :location => @lot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lots/1
  # PUT /lots/1.xml
  def update
    @lot = Lot.find(params[:id])

    respond_to do |format|
      if @lot.update_attributes(params[:lot])
        flash[:notice] = 'Lot was successfully updated.'
        format.html { redirect_to(@lot) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lots/1
  # DELETE /lots/1.xml
  def destroy
    @lot = Lot.find(params[:id])
    @lot.destroy

    respond_to do |format|
      format.html { redirect_to(lots_url) }
      format.xml  { head :ok }
    end
  end
end
