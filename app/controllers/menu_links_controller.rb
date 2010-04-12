class MenuLinksController < ApplicationController
  unloadable
  layout 'base'
  before_filter :require_admin
  before_filter :clean_menu_links, :only => [:destroy, :create, :update, :move]
  after_filter  :show_menu_links, :only => [:destroy, :create, :update, :move]
  
  verify :method => :post, :only => [ :destroy, :create, :update, :move ],
         :redirect_to => { :action => :index }
         
  def index
    @menu_link_pages, @menu_links = paginate :menu_link, :per_page => 25, :order => "position"
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
      if @menu_link.name.blank?
        flash.now[:error] = l(:error_blank_name)
      end
      if @menu_link.url.blank?
        flash.now[:error] = l(:error_blank_url)
      end
      if @menu_link.name.length > 60
        flash.now[:error] = l(:error_name_length)
      end
      if @menu_link.name.length > 255
        flash.now[:error] = l(:error_url_length)
      end
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
      if @menu_link.name.blank?
        flash.now[:error] = l(:error_blank_name)
      end
      if @menu_link.url.blank?
        flash.now[:error] = l(:error_blank_url)
      end
      if @menu_link.name.length > 60
        flash.now[:error] = l(:error_name_length)
      end
      if @menu_link.name.length > 255
        flash.now[:error] = l(:error_url_length)
      end
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
