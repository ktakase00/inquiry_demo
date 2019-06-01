class InquiriesController < ApplicationController
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]
  before_action :create_and_validate_inquiry, only: [:create]

  # GET /inquiries
  # GET /inquiries.json
  def index
    @inquiries = Inquiry.all
  end

  # GET /inquiries/1
  # GET /inquiries/1.json
  def show
  end

  # GET /inquiries/new
  def new
    @inquiry = Inquiry.new
  end

  # GET /inquiries/1/edit
  def edit
  end

  # POST /inquiries
  # POST /inquiries.json
  def create
    if @inquiry.save
      redirect_to @inquiry, { notice: make_notice(@inquiry.success?) }
    else
      render :new
    end
  end

  # PATCH/PUT /inquiries/1
  # PATCH/PUT /inquiries/1.json
  def update
    respond_to do |format|
      if @inquiry.update(inquiry_params)
        format.html { redirect_to @inquiry, notice: 'Inquiry was successfully updated.' }
        format.json { render :show, status: :ok, location: @inquiry }
      else
        format.html { render :edit }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inquiries/1
  # DELETE /inquiries/1.json
  def destroy
    @inquiry.destroy
    respond_to do |format|
      format.html { redirect_to inquiries_url, notice: 'Inquiry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inquiry
      @inquiry = Inquiry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inquiry_params
      params.require(:inquiry).permit(:inquiry_cd, :inquiry_content)
    end

    # モデルのインスタンスを生成してバリデーションを実行
    def create_and_validate_inquiry
      @inquiry = Inquiry.new(inquiry_params)
      render :new if @inquiry.invalid?
    end

    # リダイレクト時のフラッシュメッセージを生成
    def make_notice(success_flag)
      model_nm = I18n.t("activerecord.models.#{@inquiry.class.name.underscore}")
      result_cd = success_flag ? 'success' : 'failure'
      I18n.t("notice.#{params[:action]}.#{result_cd}", { model: model_nm })
    end
end
