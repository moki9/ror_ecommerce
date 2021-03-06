class Admin::Config::TaxRatesController < Admin::Config::BaseController
  helper_method :countries

  # GET /tax_rates
  def index
    @tax_rates = TaxRate.all
  end

  # GET /tax_rates/1
  def show
    @tax_rate = TaxRate.find(params[:id])
  end

  # GET /tax_rates/new
  def new
    @tax_rate = TaxRate.new
    form_info
  end

  # GET /tax_rates/1/edit
  def edit
    @tax_rate = TaxRate.find(params[:id])
    form_info
  end

  # POST /tax_rates
  def create
    @tax_rate = TaxRate.new(params[:tax_rate])

    respond_to do |format|
      if @tax_rate.save
        format.html { redirect_to(admin_config_tax_rate_url(@tax_rate), :notice => 'Tax rate was successfully created.') }
      else
        form_info
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /tax_rates/1
  def update
    @tax_rate = TaxRate.find(params[:id])

    respond_to do |format|
      if @tax_rate.update_attributes(params[:tax_rate])
        format.html { redirect_to(admin_config_tax_rate_url(@tax_rate), :notice => 'Tax rate was successfully updated.') }
      else
        form_info
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /tax_rates/1
  def destroy
    @tax_rate = TaxRate.find(params[:id])
    @tax_rate.update_attributes(:active => false)
    redirect_to(admin_config_tax_rates_url)
  end
  private

  def countries
    @countries    ||= Country.form_selector
  end

  def form_info
    @states       = State.all_with_country_id(@tax_rate.state.country_id) if  @tax_rate.state_id
    @states       ||= []
  end
end
