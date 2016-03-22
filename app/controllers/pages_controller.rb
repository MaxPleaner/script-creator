class PagesController < ApplicationController
  
  before_action(:flash_output)
  def flash_output
    @output = flash[:output]
    flash.delete(:output)
    flash[:output] = @output
  end

  def root # get
    @pages = Page.all
    if Script.count == 0
      Script.create_default_script
    end
    @scripts = Script.select(:id, :name)
    id = params[:id] || flash[:id]
    if id
      @script = Script.find_by(id: id)
      unless @script
        render json: { errors: "Script not found" }.to_json, status: 422
        return false
      end
    end
  end

  def html_page
    @pages = Page.all.select(:name)
    name = URI.decode(params[:name] || "")
    @page = Page.find_by(name: name)
    unless @page
      flash[:messages] = [flash[:messages], "cant find that page"].flatten.compact
      redirect_to "/"
      return false
    end
    render :html_page
  end

  def html_page_params
    params.permit(:name, :content)
  end

  def save_html_page
    page = Page.find_by(id: params[:id]) || Page.new 
    page.update(html_page_params)
    flash[:messages] = [flash[:messages], "Saved #{page.name} page "].flatten
    redirect_to :back
  end

  def delete_html_page
    page = Page.find_by(id: params[:id])
    unless page
      render json: { errors: "photo not found" }.to_json, status: 422
    end
    page.destroy
    flash[:messages] = [flash[:messages], "Deleted #{page.name} page "].flatten
    redirect_to "/"
  end

  def create # post
    if params[:id]
      @script = Script.find_by(id: params[:id])
    else
      @script = Script.new
    end
    @script.name = params[:name]
    @script.content = params[:content]
    if @script.valid?
      @script.save
      flash[:messages] = [flash[:messages], "Saved #{@script.name} script "].flatten
      redirect_to "/?id=#{@script.id}"
    else
      render json: { errors: @script.errors.full_messages.join(", ") }.to_json, status: 422
      return false
    end
  end

  def script # get
    @pages = Page.all
    @scripts = Script.all
    @script = Script.find_by(id: params[:id])
    unless @script
      render json: { errors: "Script not found" }.to_json, status: 422
      return false
    end
    render "root"
  end
  def execute
    @script = Script.find_by(id: params[:id])
    unless @script
      render json: { errors: "Script not found" }.to_json, status: 422
      return false
    end
    flash[:messages] = [flash[:messages], "Ran #{@script.name} script "].flatten
    flash[:id] = @script.id
    tempfile = Tempfile.new("script-#{@script.id}.rb")
    path = tempfile.path
    tempfile.write(@script.content)
    tempfile.rewind; tempfile.close
    flash[:output] ||= ""
    output = <<-OUTPUT

=====================================
(<a href="script?id=#{@script.id}">#{@script.name.red_on_black}</a>) output
=====================================
#{`ruby #{tempfile.path}`}

OUTPUT
    flash[:output] += output.html_safe
    tempfile.unlink
    redirect_to "/"
  end
  def delete
    @script = Script.find_by(id: params[:id])
    unless @script
      render json: { errors: "Script not found" }.to_json, status: 422
      return false
    end
    flash[:messages] = [flash[:messages], "Confirm deletion for #{@script.name} script "].flatten
  end
  def clear_output
    flash.delete(:output)
    redirect_to :back
  end
  def confirm_destroy
    @script = Script.find_by(id: params[:id])
    unless @script
      render json: { errors: "Script not found" }.to_json, status: 422
      return false
    end
    flash[:messages] = [flash[:messages], "Deleted #{@script.name} script "].flatten
    @script.destroy
    redirect_to "/"
  end
end
