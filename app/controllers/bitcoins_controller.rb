class BitcoinsController < ApplicationController
  include HTTParty
  before_action :set_bitcoin, only: [:show, :edit, :update, :destroy]

  def index
    @bitcoins = Bitcoin.all
  end

  def show
  end

  def new
    @bitcoin = Bitcoin.new
  end

  def create
    response = HTTParty.get("https://blockchain.info/rawblock/#{bitcoin_params["hashb"]}")
    b_arr = JSON.parse(response&.body || "{}")
    @bitcoin = Bitcoin.new(hashb:"#{b_arr["hash"]}",prev_block:"#{b_arr["prev_block"]}",block_index:"#{b_arr["block_index"]}",time:"#{b_arr["time"]}",bits:"#{b_arr["bits"]}")

    if @bitcoin.save
      redirect_to bitcoins_path, notice: "Bitcoin was successfully created."
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
    redirect_to bitcoins_path, notice: "Bitcoin was successfully destroyed."
  end

  private

  def set_bitcoin
    @bitcoin = Bitcoin.find(params[:id])
  end

  def bitcoin_params
    params.require(:bitcoin).permit(:hashb)
  end
end
