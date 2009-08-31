class SpeciesController < ApplicationController
    before_filter :editor_required, :except=>[:index,:show]
    
  # GET /species
  # GET /species.xml
  def index
    @species = Species.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @species }
    end
  end

  # GET /species/1
  # GET /species/1.xml
  def show
    @species = Species.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @species }
    end
  end

  # GET /species/new
  # GET /species/new.xml
  def new
    @species = Species.new
    @species.image = SpeciesImage.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @species }
    end
  end

  # GET /species/1/edit
  def edit
    @species = Species.find(params[:id])
  end

  # POST /species
  # POST /species.xml
  def create
    @species = Species.new(params[:species])

    respond_to do |format|
      if @species.save
        flash[:notice] = 'Species was successfully created.'
        format.html { redirect_to(@species) }
        format.xml  { render :xml => @species, :status => :created, :location => @species }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @species.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /species/1
  # PUT /species/1.xml
  def update
    @species = Species.find(params[:id])

    respond_to do |format|
      if @species.update_attributes(params[:species])
        flash[:notice] = 'Species was successfully updated.'
        format.html { redirect_to(@species) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @species.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /species/1
  # DELETE /species/1.xml
  def destroy
    @species = Species.find(params[:id])
    @species.destroy
    
    flash[:notice] = 'Species was deleted.'

    respond_to do |format|
      format.html { redirect_to(species_index_url) }
      format.xml  { head :ok }
    end
  end
end
