class ApplicationsController < ApplicationController
  before_action :validate_params, only: [:create]

  def create
    AppsWorker.perform_async(@params['name'])
    render json: { 'response': 'App creation request added'}, status: :accepted
  end

  def update
    app = Application.find_by_token(params[:token])
    if app
      app.update(name: params[:name])
      render json: { 'response': 'App updated', 'app': app.as_json(only: [:name, :token, :created_at]) }, status: :ok
    else
      render json: { 'response': 'Invalid Token' }, status: :no_content
    end
  end
  

  def get_all
    apps = Application.all
    if apps
      render json: { 'response': 'OK', 'apps': apps.as_json(only: [:name, :token, :chats_count, :created_at]) }, status: :ok
    else
      render json: { 'response': 'No apps created' }, status: :no_content
    end
  end

  def find_by_token
    app = Application.find_by_token(params[:token])
    if app
      render json: { 'response': 'OK', 'app': app.as_json(only: [:name, :token, :chats_count, :created_at]) }, status: :created
    else
      render json: { 'response': 'Invalid Token' }, status: :no_content
    end
  end



  private
  def validate_params
    @params = params.permit('name')
    if @params == {}
      render json: 'Invalid parameters', status: :unprocessable_entity
    elsif @params['name'] == ""
      render json: 'App name cannot be empty', status: :unprocessable_entity
    end
  end

end





