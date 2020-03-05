include Pagy::Backend

class ClientsController < ApplicationController
  load_and_authorize_resource

  def index
    @pagy, @clients = pagy(@clients, items: 25)
  end

  def show;  end
  def new;   end
  def edit;  end

  def parse
    Client.make_parse
    redirect_to clients_path
  end

  def create
    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
    end
  end

  private

    def client_params
      params.require(:client).permit(:title, :desc, :email, :phone, :url, :site, :send_hello, :categories)
    end
end
