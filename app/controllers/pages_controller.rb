class PagesController < ApplicationController
  
  before_action(:flash_output)
  def flash_output
    @output = flash[:output]
    flash.delete(:output)
    flash[:output] = @output
  end

  def root # get
    @scripts = Script.select(:id, :name)
    id = params[:id] || flash[:id]
    if id
      @script = Script.find_by(id)
      unless @script
        render json: { errors: "Script not found" }.to_json, status: 422
        return false
      end
    end
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
      redirect_to "/?id=#{@script[:id]}"
    else
      render json: { errors: @script.errors.full_messages.join(", ") }.to_json, status: 422
      return false
    end
  end
  def script # get
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
    flash[:id] = @script.id
    tempfile = Tempfile.new("script-#{@script.id}.rb")
    path = tempfile.path
    tempfile.write(@script.content)
    tempfile.rewind; tempfile.close
    flash[:output] ||= ""
    output = <<-OUTPUT

=====================================
#{(@script.name).red_on_black} output
=====================================
#{`ruby #{tempfile.path}`}

OUTPUT
    flash[:output] += output
    tempfile.unlink
    redirect_to "/"
  end
  def delete
    @script = Script.find_by(id: params[:id])
    unless @script
      render json: { errors: "Script not found" }.to_json, status: 422
      return false
    end
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
    @script.destroy
    redirect_to "/"
  end
end
