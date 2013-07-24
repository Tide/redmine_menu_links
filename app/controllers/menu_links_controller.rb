class MenuLinksController < ApplicationController
  unloadable
  layout 'admin'
  before_filter :require_admin
  before_filter :clean_menu_links, :only => [:destroy, :create, :update, :move]
  after_filter  :show_menu_links, :only => [:destroy, :create, :update, :move]

  def index
    @menu_links_count = MenuLink.find(:all).count
    @menu_links_pages = Paginator.new(@menu_links_count, per_page_option, params[:page])
    @offset ||= @menu_links_pages.offset
    @menu_links = MenuLink.find(:all,
                          :order => "#{MenuLink.table_name}.position ASC",
                          :offset => @offset,
                          :limit => per_page_option)
                          
    render :action => "index", :layout => false if request.xhr?
  end

  def new
    @menu_link = MenuLink.new
  end

  def create
    @menu_link = MenuLink.new(params[:menu_link])
    if @menu_link.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @menu_link = MenuLink.find(params[:id])
  end

  def update
    @menu_link = MenuLink.find(params[:id])
    if @menu_link.update_attributes(params[:menu_link])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    MenuLink.find(params[:id]).destroy
    redirect_to :action => 'index'
  rescue
    flash[:error] = l(:error_unable_delete_menu_link)
    redirect_to :action => 'index'
  end 

  private
  def clean_menu_links
    MenuLink.clean
  end
  def show_menu_links
    MenuLink.show
  end
end
