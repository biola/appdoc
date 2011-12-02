class DocumentsController < ApplicationController

  respond_to :html
  respond_to :js, :only => :index

  # Authorization
  if respond_to? :filter_access_to
    filter_access_to :all # Devise
  elsif respond_to? :check_authorization
    check_authorization # cancan
  end

  def index
    
    if params[:search].blank?
      @documents = Document.scoped
    else
      @documents = Document.named(params[:search])
      @documents = @documents.tagged_with(params[:tag]) unless params[:tag].blank?
    end
    
    # First check if using kaminari for pagination, else check for will_paginate
    begin  
      @documents = @documents.page(params[:page])
    rescue NoMethodError
      @documents = @documents.try(:paginate, :page => params[:page])
    end

    respond_with(@documents) do |format|
      format.html { flash.now[:alert] = "No documents were found" if @documents.empty? }
      format.js { render :partial=>'documents' }
    end
  end

  def show
    @document = Document.find_by_id_or_slug!(params[:id])
  end

  def new
    @document = Document.new
  end

  def edit
    @document = Document.find_by_id_or_slug!(params[:id])
  end

  def create
    @document = Document.new(params[:document])
    if @document.save
      flash[:notice] = 'Document was successfully created.'
    end
    respond_with @document
  end

  def update
    @document = Document.find_by_id_or_slug!(params[:id])
    if @document.update_attributes(params[:document])
      flash[:notice] = 'Document was successfully updated.'
    end
    respond_with @document
  end

  def destroy
    @document = Document.find_by_id_or_slug!(params[:id])
    @document.destroy
    respond_with @document
  end
  
end
