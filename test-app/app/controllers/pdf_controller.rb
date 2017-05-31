class PdfController < ApplicationController
  def static
    respond_to do |format|
      format.pdf { render pdf: 'static' }
    end
  end
end
