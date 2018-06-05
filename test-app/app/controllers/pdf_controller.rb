class PdfController < ActionController::Base
  protect_from_forgery with: :exception

  def static
    respond_to do |format|
      format.pdf { render pdf: 'static' }
    end
  end
end
