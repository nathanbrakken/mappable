class StoresController < ApplicationController
  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
      # binding.pry
      format.csv { send_data Store.generate_csv(['id' , 'name', 'address', 'x_coord', 'y_coord', 'store_number' ], @stores)}
      format.xlsx {
        xlsx_package = Store.to_xlsx
        send_data xlsx_package.to_stream.read, :filename => 'stores.xlsx', :type=> "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      } 

    end
  end

  def import
    logger.debug params[:file]
    params[:file].nil? do
      flash[:error] = 'You need a file'
      redirect_to stores_path
    end
    Store.import(params[:file])
    redirect_to stores_path, notice: "Stores imported."
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/new
  # GET /stores/new.json
  def new
    @store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find(params[:id])
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(params[:store])
    
    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render json: @store, status: :created, location: @store }
      else
        format.html { render action: "new" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stores/1
  # PUT /stores/1.json
  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to stores_url notice: 'Store was successfully deleted.'}
      format.json { head :no_content }
    end
  end

  def update_coords
    @stores = Store.all
  end


end
