class BitcoinsController < ApplicationController
  include HTTParty
  before_action :set_bitcoin, only: [:show, :edit, :update, :destroy]

  def index
    @pagy ,@bitcoins = pagy(Bitcoin.ordered, items: 7)
  end

  def show
  end

  def new
    @bitcoin = Bitcoin.new
  end

  def create
    response = HTTParty.get("https://blockchain.info/rawblock/#{bitcoin_params["hashb"]}")
    b_arr = JSON.parse(response&.body)
    @bitcoin = Bitcoin.new(hashb:"#{b_arr["hash"]}",prev_block:"#{b_arr["prev_block"]}",block_index:"#{b_arr["block_index"]}",time:"#{b_arr["time"]}",bits:"#{b_arr["bits"]}")

    if b_arr["error"]!="not-found-or-invalid-arg" && @bitcoin.save
      respond_to do |format|
        format.html { redirect_to bitcoins_path, notice: "Hash added." }
        format.turbo_stream { flash.now[:notice] = "Hash added." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @bitcoin.update(bitcoin_params)
      redirect_to bitcoins_path, notice: "Bitcoin was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bitcoin.destroy
    respond_to do |format|
      format.html { redirect_to bitcoins_path, notice: "Hash destroyed." }
      format.turbo_stream { flash.now[:notice] = "Hash destroyed." }
    end
  end

  private

  def set_bitcoin
    @bitcoin = Bitcoin.find(params[:id])
  end

  def bitcoin_params
    params.require(:bitcoin).permit(:hashb)
  end
end
