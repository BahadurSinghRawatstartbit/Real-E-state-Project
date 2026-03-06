class FaqsController < ApplicationController
   before_action :require_admin
  def index
    @faqs = Faq.all
  end
  def new
    @faq=Faq.new
    
  end
  def edit
    @faq = Faq.find(params[:id])
  end
  # def create
  #   @faqs=Faq.new(faq_parms)
  #   if current_user.admin?
  #     respond_to do |format|
  #       if @faqs.save
  #       format.js
  #       format.html  { redirect_to faqs_path, notice: "Property created successfully" }
        
  #       else
  #         format.js
  #         format.html { render :new }
          
  #       end
  #     end
  #   end

  # end
  # 
  def create
    return redirect_to root_path unless current_user.admin?

    @faq = Faq.new(faq_parms)

    if @faq.save
      redirect_to faqs_path, notice: "FAQ created successfully"
    else
      render :new
    end
  end
  

  
  def update
    @faq = Faq.find(params[:id])
    if @faq.update(faq_parms)
      
      redirect_to faqs_path, notice: "FAQ updated successfully"
    else
      render :edit
    end
    
  end

 
  def destroy
    @faq = Faq.find(params[:id])
    @faq.destroy
    respond_to do |format|
     format.html { redirect_to faqs_path }
     format.js 
    end
  end
  
  private

  def faq_parms
    params.require(:faq).permit(:category,:question,:answer)
  end
end
