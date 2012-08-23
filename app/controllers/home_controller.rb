class HomeController < ApplicationController
  def index
    
    if params[:note]
      
      chord = Chord.new(params)
      
      @chord_name = chord.name
      @chord_notes = chord.get_notes.join(' - ')
      
    end
    
    respond_to do |format|
      format.html
      format.js
    end
    
  end
end
